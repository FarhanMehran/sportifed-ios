//
//  ChatEndpoints.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 14/06/2024.
//

import Foundation

enum ChatEndpoints: NetworkRequtable {
    

    case getCommunities
    case getAllUsers
    case getUserChat
    case chatsSend(req: SendChatModel)
    case createNewGroup(request: CreatGroupRequest)
    case makeCaptain(request: MakeCaptainRequest)
    case addRemoveUserGroup(request: RemoveUserFromGroupRequest)
    case getCommunityChat(req: SportFilterRequest)
    
   
    var url: String {
        let baseUrl = NetworkConfiguration.shared.getBaseURL()
        switch self {
        case .getCommunities:
            return baseUrl.appending("chats/get_communities/")
        case .getAllUsers:
            return baseUrl.appending("chats/get_users_group/")
        case .createNewGroup:
            return baseUrl.appending("chats/create_group/")
        case .getUserChat:
            return baseUrl.appending("chats/all/")
        case .makeCaptain:
            return baseUrl.appending("sports/make_captain/")
        case .addRemoveUserGroup:
            return baseUrl.appending("chats/add_remove_user_group/")
        case .chatsSend:
            return baseUrl.appending("chats/send/")
        case .getCommunityChat:
            return baseUrl.appending("chats/messages/")
           
        }
    }
    
    var queryItems: [String: String]? {
        switch self {
        case .getCommunities, .createNewGroup, .getAllUsers, .getUserChat, .makeCaptain, .addRemoveUserGroup,.chatsSend:
            return [:]
        case .getCommunityChat(let request):
            return request.makeRequestParam()

        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case  .getCommunities, .getAllUsers, .getUserChat,.getCommunityChat:
            return .GET
        case  .createNewGroup, .makeCaptain, .addRemoveUserGroup,.chatsSend:
            return .POST
        }
    }
    
    var body: Data? {
        switch self {
        case .getCommunities, .getAllUsers, .getUserChat,.getCommunityChat:
            return nil
        case .createNewGroup(let CreatGroupRequest) :
            return CreatGroupRequest.encode()
        case .makeCaptain(let MakeCaptainRequest) :
            return MakeCaptainRequest.encode()
        case .addRemoveUserGroup(let RemoveUserFromGroupRequest) :
            return RemoveUserFromGroupRequest.encode()
        case .chatsSend(let SendChatModel) :
            return SendChatModel.encode()
        }
  
    }
    
}
