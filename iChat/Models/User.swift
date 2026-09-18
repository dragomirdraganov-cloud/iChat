//
//  User.swift
//  iChat
//
//  Created by Dragomir Draganov Karlova on 17/09/2026.
//

import Foundation
import SwiftData

//struct User: Identifiable, Codable, Hashable {
//    var id: UUID
//    var name: String
//    var createdAt: Date
//    
//    init(id: UUID = UUID(), name: String, createdAt: Date = .now) {
//        self.id = id
//        self.name = name
//        self.createdAt = createdAt
//    }
//}

@Model
final class User {
    var id: UUID
    var username: String
    var createdAt: Date
    
    init(id: UUID = UUID(), username: String, createdAt: Date = .now) {
        self.id = id
        self.username = username
        self.createdAt = createdAt
    }
}
