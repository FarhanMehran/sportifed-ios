//
//  Requestable.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 08/05/2024.
//

import Combine
import Foundation

/// NetworkErrorModel - contains error part
/// error - such as errorCode, Message, Detailed Message
/// All Response model should inherit this model
public struct NetworkErrorModel: Error, Codable {
    let statusCode: String?
    let msg: String?
    let message: String?
    let success: Bool?
    init(statusCode: String = "", message: String, msg: String = "", success: Bool = true) {
        self.statusCode = statusCode
        self.msg = msg
        self.message = message
        self.success = success
    }
}

// MARK: - Message
public struct Message: Codable {
    public var msg: String?
    public var message: String?
   

    enum CodingKeys: String, CodingKey {
        case msg = "msg"
        case message = "message"
    }
}


public typealias CommonResponse<T: Codable> = AnyPublisher<T, NetworkErrorModel>

public protocol Requestable {
    var requestTimeOut: Float { get }
    
    func request<T> (_ req: NetworkRequtable) -> CommonResponse<T>
}
