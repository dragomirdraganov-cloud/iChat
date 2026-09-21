//
//  SessionManager.swift
//  iChat
//
//  Created by Dragomir Draganov Karlova on 19/09/2026.
//

import CryptoKit
import Foundation
import Observation
import SwiftData

@MainActor
@Observable
final class SessionManager {
    enum State: Equatable {
        case restoring
        case signedOut
        case signedIn(userID: UUID)
    }

    enum AuthError: LocalizedError {
        case invalidCredentials
        case usernameTaken
        case invalidUsername
        case weakPassword

        var errorDescription: String? {
            switch self {
            case .invalidCredentials:
                "El usuario o la contraseña no son correctos."
            case .usernameTaken:
                "Ese nombre de usuario ya está registrado."
            case .invalidUsername:
                "El nombre de usuario debe tener al menos 3 caracteres."
            case .weakPassword:
                "La contraseña debe tener al menos 6 caracteres."
            }
        }
    }

    private(set) var state: State = .restoring

    private let storedUserIDKey = "auth.currentUserID"

    var currentUserID: UUID? {
        guard case .signedIn(let userID) = state else {
            return nil
        }

        return userID
    }

    var isAuthenticated: Bool {
        currentUserID != nil
    }

    func restoreSession(in context: ModelContext) {
        guard
            let storedID = UserDefaults.standard.string(forKey: storedUserIDKey),
            let userID = UUID(uuidString: storedID)
        else {
            state = .signedOut
            return
        }

        do {
            let descriptor = FetchDescriptor<User>(
                predicate: #Predicate { $0.id == userID }
            )

            guard try context.fetch(descriptor).first != nil else {
                signOut()
                return
            }

            state = .signedIn(userID: userID)
        } catch {
            signOut()
        }
    }

    func signIn(username: String, password: String, in context: ModelContext) throws {
        let normalizedUsername = username.trimmingCharacters(in: .whitespacesAndNewlines)
        let users = try context.fetch(FetchDescriptor<User>())

        guard
            let user = users.first(where: {
                $0.username.localizedCaseInsensitiveCompare(normalizedUsername) == .orderedSame
            }),
            let passwordSalt = user.passwordSalt,
            let storedHash = user.passwordHash,
            Self.hash(password: password, salt: passwordSalt) == storedHash
        else {
            throw AuthError.invalidCredentials
        }

        startSession(for: user.id)
    }

    func register(username: String, password: String, in context: ModelContext) throws {
        let normalizedUsername = username.trimmingCharacters(in: .whitespacesAndNewlines)

        guard normalizedUsername.count >= 3 else {
            throw AuthError.invalidUsername
        }

        guard password.count >= 6 else {
            throw AuthError.weakPassword
        }

        let users = try context.fetch(FetchDescriptor<User>())
        let existingUser = users.first {
            $0.username.localizedCaseInsensitiveCompare(normalizedUsername) == .orderedSame
        }

        if let existingUser, existingUser.passwordHash != nil {
            throw AuthError.usernameTaken
        }

        let salt = Self.makeSalt()
        let passwordHash = Self.hash(password: password, salt: salt)
        let user: User

        if let existingUser {
            // Permite asociar una cuenta a un usuario creado previamente por DummyData.
            existingUser.passwordSalt = salt
            existingUser.passwordHash = passwordHash
            user = existingUser
        } else {
            user = User(
                username: normalizedUsername,
                passwordHash: passwordHash,
                passwordSalt: salt
            )
            context.insert(user)
        }

        try context.save()
        startSession(for: user.id)
    }

    func signOut() {
        UserDefaults.standard.removeObject(forKey: storedUserIDKey)
        state = .signedOut
    }

    private func startSession(for userID: UUID) {
        UserDefaults.standard.set(userID.uuidString, forKey: storedUserIDKey)
        state = .signedIn(userID: userID)
    }

    private static func makeSalt() -> String {
        var generator = SystemRandomNumberGenerator()
        let bytes = (0..<16).map { _ in
            UInt8.random(in: .min ... .max, using: &generator)
        }
        return Data(bytes).base64EncodedString()
    }

    private static func hash(password: String, salt: String) -> String {
        var data = Data(base64Encoded: salt) ?? Data(salt.utf8)
        data.append(contentsOf: password.utf8)
        return SHA256.hash(data: data)
            .map { String(format: "%02x", $0) }
            .joined()
    }
}
