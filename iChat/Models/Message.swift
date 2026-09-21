//
//  Message.swift
//  iChat
//
//  Created by Dragomir Draganov Karlova on 17/09/2026.
//

import Foundation
import SwiftData

//struct Message: Identifiable, Codable, Hashable {
//    var id: UUID
//    var chatID: UUID
//    var senderID: UUID
//
//    var content: String
//
//    var sentAt: Date
//    var editedAt: Date?
//
//    var replayToMessageID: UUID?
//
//    init(id: UUID = UUID(), chatID: UUID, senderID: UUID, content: String, sentAt: Date = .now, editedAt: Date? = nil, replayToMessageID: UUID? = nil) {
//        self.id = id
//        self.chatID = chatID
//        self.senderID = senderID
//        self.content = content
//        self.sentAt = sentAt
//        self.editedAt = editedAt
//        self.replayToMessageID = replayToMessageID
//    }
//}

@Model
final class Message {
    var id: UUID

    var chat: Chat?
    var sender: User?

    var content: String

    var sentAt: Date
    var editedAt: Date?

    var replayToMessageID: UUID?

    init(id: UUID = UUID(), chat: Chat? = nil, sender: User? = nil, content: String, sentAt: Date = .now, editedAt: Date? = nil, replayToMessageID: UUID? = nil) {
        self.id = id
        self.chat = chat
        self.sender = sender
        self.content = content
        self.sentAt = sentAt
        self.editedAt = editedAt
        self.replayToMessageID = replayToMessageID
    }
}
