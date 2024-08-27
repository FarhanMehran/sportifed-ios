//
//  NativeRequestable.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 08/05/2024.
//

import Foundation
import Combine
import Alamofire

public class NativeRequestable: Requestable {
    
    public var requestTimeOut: Float = 20
    private let reachabilityService = ReachabilityService()
    
    
    public init() {
    }
    
    private func checkInternetConnection() -> Bool {
        return reachabilityService.reachabilityType == .connected
    }
    
  
    public func request<T>(_ req: NetworkRequtable) -> CommonResponse<T>
    where T: Decodable, T: Encodable {
    
        if !checkInternetConnection() {
            return Fail(error: NetworkErrorModel(message: "No internet connection.")).eraseToAnyPublisher()
        }
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = TimeInterval(requestTimeOut)
        
        guard let completeRequest = req.urlRequest else {
            // Return a fail publisher if the url is invalid
            return AnyPublisher(
                Fail<T, NetworkErrorModel>(error: NetworkErrorModel(message: "Invalid Url"))
            )
        }
        
        // We use the dataTaskPublisher from the URLSession which gives us a publisher to play around with.
        return URLSession.shared
            .dataTaskPublisher(for: completeRequest)
            .receive(on: DispatchQueue.main)
            .mapError { error in

                if error.errorCode == -1001 {
                    //
                    // Return custom error
                    return NetworkErrorModel(message: "RequestTimedOut")
                } else {
                    return NetworkErrorModel(message: String(describing: error.localizedDescription))
                }
            }
            .flatMap { data, response -> AnyPublisher<T, NetworkErrorModel> in  // <-- here
                
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: NetworkErrorModel(message: "Something went wrong")).eraseToAnyPublisher()
                }
                print("-------------------------------------------------")
                print("response code = \(String(describing: response.statusCode))")
                if let utf8Text = String(data: data, encoding: .utf8) {
                    print("API: \(String(describing: response.url) ) \n\n\n Data: \(utf8Text)")
                }
                print("-------------------------------------------------")
                switch response.statusCode {
                case 200...299: /// Handle success model
                    if let token = response.allHeaderFields[NetworkConstant.HearderKeys.authToken.rawValue] as? String {
                        DispatchQueue.main.async {
                            debugPrint("\(NetworkConstant.HearderKeys.authToken.rawValue): ", token)
                            UserDefaults.standard.set(token, forKey: NetworkConstant.UserDefaultsKeys.authTokenKey.rawValue)
                        }

                    } else {
                        // Handle missing token in the response header
                        print("Token not found in response header.")
                    }
                        if T.self == String.self, let utf8Text = String(data: data, encoding: .utf8){
                            return Just(utf8Text as! T)
                                .mapError {  error in
                                    if error is DecodingError {
                                        //inable to server resqusrt
                                        return NetworkErrorModel(message: "decodingError")
                                }else{
                                    print("other")
                                    return NetworkErrorModel(message: String(describing: error.localizedDescription))
                                }
}
                                .eraseToAnyPublisher()
                           
                        } else {
                            let jsonDecoder = JSONDecoder()

                            return Just(data)
                                .decode(type: T.self, decoder: jsonDecoder)  // <-- here
                                .mapError { error in
                                    if error is DecodingError {
                                        
                                        return NetworkErrorModel(message: "decodingError")
                                    }else{
                                        print("other")
                                        return NetworkErrorModel(message: String(describing: error.localizedDescription))
                                    }
                                }
                                .eraseToAnyPublisher()
                           
                        }
                case 401:  /// Auth Session
                    do {
                        let errorModel = try JSONDecoder().decode(NetworkErrorModel.self, from: data)
                        return Fail(error: NetworkErrorModel(statusCode: errorModel.statusCode ?? "", message: "Your session has expired. Please log in again.")).eraseToAnyPublisher()
                    } catch let error {
                        return Fail(error: NetworkErrorModel(message: String(describing: error.localizedDescription))).eraseToAnyPublisher()
                    }
                case 400...500:  /// Handle failure error  model
                    do {
                        let errorModel = try JSONDecoder().decode(NetworkErrorModel.self, from: data)
                        return Fail(error:  errorModel).eraseToAnyPublisher()
                    } catch let error {
                        return Fail(error: NetworkErrorModel(message: String(describing: error.localizedDescription))).eraseToAnyPublisher()
                    }
                default:
                    // TODO: handle 502 error
                    return Fail(error: NetworkErrorModel(message: "Unable to complete request. please try later")).eraseToAnyPublisher()
                    
                }
            }
            .eraseToAnyPublisher()
    }
}

class APIManager {
    
    static let shared = APIManager()
    
    private let reachabilityService = ReachabilityService()
    
    private init() {}
    
    
    private func performInternalMultipartRequest<ResultType: Codable, E: Codable>(method: HTTPMethod,
                                                                                  endpoint: String,
                                                                                  parameters: [String: Any]?,
                                                                                  imageData: Data?,
                                                                                  imageKey: String,
                                                                                  videoData: Data?,
                                                                                  videoKey: String?,
                                                                                  headers: [String: String]?,
                                                                                  success: @escaping (ResultType) -> Void,
                                                                                  failure: @escaping (E) -> Void) {
        
        AF.upload(multipartFormData: { multipartFormData in
            // Add other parameters
            if let parameters = parameters {
                for (key, value) in parameters {
                    if let data = "\(value)".data(using: .utf8) {
                        multipartFormData.append(data, withName: key)
                    }
                }
            }
            
            // Add image data if available
            if let imageData = imageData {
                multipartFormData.append(imageData, withName: imageKey, fileName: "image.jpg", mimeType: "image/jpeg")
            }
            if let videoData = videoData {
                multipartFormData.append(videoData, withName: videoKey ?? "", fileName: "video.mp4", mimeType: "video/mp4")
                   }
        }, to: endpoint, method: .post, headers: HTTPHeaders(headers ?? [:]))
        .validate()
        .responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode(ResultType.self, from: data)
                    success(decodedData)
                } catch {
                    let decodingErrorMessage = "Error decoding response data: \(error.localizedDescription)"
                    
                }
            case .failure(let error):
                let networkErrorMessage = "Network error: \(error.localizedDescription)"
                
            }
        }
    }
    
    func uploadImage<T: Codable, E: Codable>(endpoint: String,
                                             parameters: [String: Any]?,
                                             imageData: Data,
                                             imageKey: String,
                                             headers: [String: String]?,
                                             success: @escaping (T) -> Void,
                                             failure: @escaping (E) -> Void) {
        
        performInternalMultipartRequest(method: .POST,
                                endpoint: endpoint,
                                parameters: parameters,
                                imageData: imageData,
                                imageKey: imageKey, videoData: nil,videoKey: nil,
                                headers: headers,
                                success: success,
                                failure: failure)
    }
}

final class UserService {
    
    static let shared = UserService()
    
    public func editUserImage<ResultType: Codable>(imageData: Data,
                                                   parameters: [String: String],
                                                   completion: @escaping (Result<ResultType, Error>) -> Void) {
      
        
      
        let authToken = /*StringConstants.authToken*/ UserDefaults.standard.string(forKey: NetworkConstant.UserDefaultsKeys.authTokenKey.rawValue)


       
        // Perform the PATCH request using APIManager
        APIManager.shared.uploadImage(endpoint: "http://3.83.13.164/auth/update_profile/",
                                      parameters:parameters, // Optional parameters
                                      imageData: imageData,
                                      imageKey: "img",
                                      headers: ["Authorization":  "Bearer \(authToken ?? "")"],
                                      success: { (data: ResultType) in
            completion(.success(data))
        },
                                      failure: { (error: String) in
            let mappedError: Error = "error" as! Error // Mapping APIError to Error
            completion(.failure(mappedError))
        })
    }
}
