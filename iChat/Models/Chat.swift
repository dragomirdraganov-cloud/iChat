//
//  Chat.swift
//  iChat
//
//  Created by Dragomir Draganov Karlova on 17/09/2026.
//

import Foundation
import SwiftData

//struct Chat: Identifiable, Codable, Hashable {
//    var id: UUID
//    var chatType: ChatType
//
//    var title: String?
//
//    var participantIDs: [UUID]
//
//    var lastMessageID: UUID?
//    var lastActivityAt: Date
//
//    init(id: UUID = UUID(), chatType: ChatType, title: String? = nil, participantIDs: [UUID], lastMessageID: UUID? = nil, lastActivityAt: Date = .now) {
//        self.id = id
//        self.chatType = chatType
//        self.title = title
//        self.participantIDs = participantIDs
//        self.lastMessageID = lastMessageID
//        self.lastActivityAt = lastActivityAt
//    }
//}

@Model
final class Chat {
    var id: UUID
    var chatType: ChatType

    var title: String?
    var createdAt: Date

    @Relationship(deleteRule: .cascade, inverse: \Message.chat)
    var messages: [Message] = []

    var lastMessage: Message?

    init(id: UUID = UUID(), chatType: ChatType, title: String? = nil, createdAt: Date = .now) {
        self.id = id
        self.chatType = chatType
        self.title = title
        self.createdAt = createdAt
    }
}

enum ChatType: String, Codable {
    case direct
    case group
}

struct ChatPreview {
    var chat: Chat
    var lastMessage: Message?
}
