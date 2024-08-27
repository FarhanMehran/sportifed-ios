//
//  NetworkRequest.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 08/05/2024.
//

import Foundation
public typealias Headers = [String: String]

public enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}

public protocol NetworkRequtable {
    var url: String { get }
    var body: Data? { get }
    var queryItems: [String: String]? { get }
    var httpMethod: HTTPMethod { get }
}

extension NetworkRequtable {
    
    var urlRequest: URLRequest? {
        guard let url = URL(string: url) else { return nil }
        let queryUrl = addQueryItems(url: url)
        print("Query URL is ", queryUrl)
        var urlRequest = URLRequest(url: queryUrl)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = getAllHeaders()
        urlRequest.httpBody = body
        return urlRequest
    }
    
    private func addQueryItems(url: URL) -> URL {
        guard let queryItems = queryItems, var urlComponents = URLComponents(string: url.absoluteString) else { return url }
        let queries = queryItems.map({ URLQueryItem(name: $0, value: $1) })
        urlComponents.queryItems = queries
        return urlComponents.url!
    }
    
    /// getCommonHeader:
    private func getCommonHeader() -> Headers {
        var commonHeaders: Headers = [:]
        commonHeaders["Content-Type"] = "application/json"
        
        let authToken = /*StringConstants.authToken*/ UserDefaults.standard.string(forKey: NetworkConstant.UserDefaultsKeys.authTokenKey.rawValue)


        if authToken != nil {
            commonHeaders[NetworkConstant.HearderKeys.authToken.rawValue] = "Bearer \(authToken ?? "")"
        }
        debugPrint(commonHeaders)
        return commonHeaders
    }
    //e3948f36-029b-4723-9e54-4db13943f939-ANM
    private func getAllHeaders() -> Headers {
        var commonHeaders = getCommonHeader()
        
        guard let headers = headers else {
            return commonHeaders
        }
        
        headers.forEach { (key, value) in commonHeaders[key] = value }
        
        return commonHeaders
    }
    
}

/// Default implementation
extension NetworkRequtable {
    var requestTimeOut: Float? {
        return 15.0
    }
    
    var headers: [String: String]? {
        return nil
    }
    
    var body: Data? {
        return nil
    }
}

protocol LocalizedDescription: Error {
    var debugDescription: String { get }
    var errorCode: String? { get }
}

/// Default implementation
extension LocalizedDescription {
    var errorCode: String? {
        return nil
    }
}

public enum NetworkError: Equatable, LocalizedDescription {
    case badURL(_ error: String)
    case apiError(errorCode: String, detailedMessage: String)
    case invalidJSON(_ error: String)
    case unauthorized(code: Int, error: String)
    case badRequest(code: Int, error: String)
    case serverError(code: Int, error: String)
    case noResponse(_ error: String)
    case unableToParseData(_ error: String)
    case unknown(code: Int, error: String)
    
    var debugDescription: String {
        switch self {
        case .badURL:
            return "Unable to find host"
        case .apiError(_, let detailedMessage):
            return "\(detailedMessage)"
        case .invalidJSON(let desc):
            return "\(desc)"
        case .unauthorized(let code, let error):
            return "Invalid Session \(code) \(error)"
        case .unableToParseData:
            return "Unable to parse data. please try later"
        case .unknown(_, let error):
            return "\(error)"
        default:
            return "Unable to complete request. please try later"
        }
    }
    
    var errorCode: String? {
        switch self {
        case .apiError(let errorCode, _):
            return errorCode
        default:
            return nil
        }
    }
}

extension Encodable {
    public func encode() -> Data? {
        do {
            let data =  try JSONEncoder().encode(self)
            print("---- Request Params ----")
            print(prettyPrintedJson(data: data))
            return data
        } catch {
            return nil
        }
    }
    
    //MARK: - Pretty Print Json
    private func prettyPrintedJson(data: Data?) {
        if let json = try? JSONSerialization.jsonObject(with: data ?? Data(), options: .mutableContainers),
           let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
            print(String(decoding: jsonData, as: UTF8.self))
        } else {
            print("json data malformed")
        }
    }
}
