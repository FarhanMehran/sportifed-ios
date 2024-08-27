//
//  GetChatModel.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 08/08/2024.
//

import Foundation
// MARK: - GetChatData
class GetChatData: Codable {
    var count: Int?
    var next, previous: String?
    var results: [ChatResult]?

    init(count: Int?, next: String?, previous: String?, results: [ChatResult]?) {
        self.count = count
        self.next = next
        self.previous = previous
        self.results = results
    }
}

// MARK: - Result
class ChatResult: Codable,Hashable {
    static func == (lhs: ChatResult, rhs: ChatResult) -> Bool {
        lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
           hasher.combine(id)
           // You can combine more properties if needed
       }
    var id: Int?
    var sender: Sender?
    var message: String?
    var chat: Chat?
    var createdAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id, sender, message, chat
        case createdAt = "created_at"
    }

    init(id: Int?, sender: Sender?, message: String?, chat: Chat?, createdAt: String?) {
        self.id = id
        self.sender = sender
        self.message = message
        self.chat = chat
        self.createdAt = createdAt
    }
}

// MARK: - Chat
class Chat: Codable {
    var id: Int?
    var name: String?
    var userOne, userTwo: User?
    var community: Community?

    enum CodingKeys: String, CodingKey {
        case id, name
        case userOne = "user_one"
        case userTwo = "user_two"
        case community
    }

    init(id: Int?, name: String?, userOne: User?, userTwo: User?, community: Community?) {
        self.id = id
        self.name = name
        self.userOne = userOne
        self.userTwo = userTwo
        self.community = community
    }
}

// MARK: - Community
class Community: Codable {
    var id: Int?
    var members: [Sender]?

    init(id: Int?, members: [Sender]?) {
        self.id = id
        self.members = members
    }
}

// MARK: - Sender
class Sender: Codable {
    var id: Int?
    var fullName, role, img: String?
    var isSend:Bool = false
    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case role, img
    }

    init(id: Int?, fullName: String?, role: String?, img: String?,isSend:Bool = false) {
        self.id = id
        self.fullName = fullName
        self.role = role
        self.img = img
        self.isSend = isSend
    }
}

class SocketModel: Codable {
    var message, sender, time: String?
    var chatID: Int?

    enum CodingKeys: String, CodingKey {
        case message, sender, time
        case chatID = "chat_id"
    }

    init(message: String?, sender: String?, time: String?, chatID: Int?) {
        self.message = message
        self.sender = sender
        self.time = time
        self.chatID = chatID
    }
}
