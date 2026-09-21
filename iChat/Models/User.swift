//
//  User.swift
//  iChat
//
//  Created by Dragomir Draganov Karlova on 17/09/2026.
//

import Foundation
import SwiftData

@Model
final class User {
    var id: UUID
    var username: String
    var createdAt: Date
    var passwordHash: String?
    var passwordSalt: String?

    init(
        id: UUID = UUID(),
        username: String,
        createdAt: Date = .now,
        passwordHash: String? = nil,
        passwordSalt: String? = nil
    ) {
        self.id = id
        self.username = username
        self.createdAt = createdAt
        self.passwordHash = passwordHash
        self.passwordSalt = passwordSalt
    }
}
