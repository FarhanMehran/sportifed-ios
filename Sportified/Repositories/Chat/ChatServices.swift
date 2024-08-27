//
//  ChatServices.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 14/06/2024.
//

import Foundation
protocol ChatServiceable {
    

    func getCommunities<T: Codable>(_ type: T.Type) -> CommonResponse<T>
    func getAllUser<T: Codable>(_ type: T.Type) -> CommonResponse<T>
    func getUserChat<T: Codable>(_ type: T.Type) -> CommonResponse<T>
    func creatNewGroup<T: Codable>(_ type: T.Type, requset: CreatGroupRequest) -> CommonResponse<T>
    func removeUserFromGroupRequest<T: Codable>(_ type: T.Type, requset: RemoveUserFromGroupRequest) -> CommonResponse<T>
    func sendMassag<T>(_ type: T.Type, requset: SendChatModel) -> CommonResponse<T>
    func getCommuntyChat<T>(_ type: T.Type, requset: SportFilterRequest) -> CommonResponse<T>
    
}

public class ChatServices: ChatServiceable {
    
    var networkRequest: Requestable
    
    public init(networkRequest: Requestable = NativeRequestable()) {
        self.networkRequest = networkRequest
    }
 
    func getCommunities<T: Codable>(_ type: T.Type) -> CommonResponse<T> {
        let endpoint = ChatEndpoints.getCommunities
        return self.networkRequest.request(endpoint)
    }
    
    func getAllUser<T: Codable>(_ type: T.Type) -> CommonResponse<T> {
        let endpoint = ChatEndpoints.getAllUsers
        return self.networkRequest.request(endpoint)
    }
    func getUserChat<T: Codable>(_ type: T.Type) -> CommonResponse<T> {
        let endpoint = ChatEndpoints.getUserChat
        return self.networkRequest.request(endpoint)
    }
    
    func creatNewGroup<T: Codable>(_ type: T.Type, requset: CreatGroupRequest) -> CommonResponse<T> {
        let endpoint = ChatEndpoints.createNewGroup(request: requset)
        return self.networkRequest.request(endpoint)
    }
    
    func removeUserFromGroupRequest<T: Codable>(_ type: T.Type, requset: RemoveUserFromGroupRequest) -> CommonResponse<T> {
        let endpoint = ChatEndpoints.addRemoveUserGroup(request: requset)
        return self.networkRequest.request(endpoint)
    }
    
    func sendMassag<T>(_ type: T.Type, requset: SendChatModel) -> CommonResponse<T> where T : Decodable, T : Encodable {
        let endpoint = ChatEndpoints.chatsSend(req: requset)
        return self.networkRequest.request(endpoint)
    }
    
    func getCommuntyChat<T>(_ type: T.Type, requset: SportFilterRequest) -> CommonResponse<T> where T : Decodable, T : Encodable {
        let endpoint = ChatEndpoints.getCommunityChat(req: requset)
        return self.networkRequest.request(endpoint)
    }
}

