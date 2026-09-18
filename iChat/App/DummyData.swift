//
//  DummyData.swift
//  iChat
//
//  Created by Dragomir Draganov Karlova on 17/09/2026.
//

import SwiftData
import Foundation
import SwiftUI

enum DummyData {

    @MainActor
    static func insertIfNeeded(into context: ModelContext, appState: AppState) throws {
        
        let chatCount = try context.fetchCount(
            FetchDescriptor<Chat>()
        )

        guard chatCount == 0 else {
            return
        }

        let me = User(
            username: "Drago"
        )

        let sergio = User(
            username: "Sergio"
        )

        let manu = User(
            username: "Manu"
        )
        
        context.insert(me)
        context.insert(sergio)
        context.insert(manu)

        let programmingChat = Chat(
            chatType: .direct,
            title: "Programación"
        )
        
        let friendsChat = Chat(
            chatType: .group,
            title: "Amigos"
        )

        context.insert(programmingChat)
        context.insert(friendsChat)

        let programmingMessage1 = Message(
            chat: programmingChat,
            sender: sergio,
            content: "Has probado a implementarte pelo?"
        )

        let programmingMessage2 = Message(
            chat: programmingChat,
            sender: me,
            content: "Sí, pero al parecer mi cabeza esta baneada del crecimiento"
        )

        let programmingMessage3 = Message(
            chat: programmingChat,
            sender: sergio,
            content: "Luego te digo como, que ahora mismo estoy siendo esclavo de la sociedad"
        )

        context.insert(programmingMessage1)
        context.insert(programmingMessage2)
        context.insert(programmingMessage3)

        programmingChat.lastMessage = programmingMessage3

        let friendsMessage1 = Message(
            chat: friendsChat,
            sender: manu,
            content: "Jugamos esta tarde?"
        )

        let friendsMessage2 = Message(
            chat: friendsChat,
            sender: me,
            content: "Siii, asi probamos el \"How to fish\"!!"
        )
        
        let friendsMessage3 = Message(
            chat: friendsChat,
            sender: sergio,
            content: "Que pintón, os cedo mi spot para que ninguno se lo pierda"
        )

        context.insert(friendsMessage1)
        context.insert(friendsMessage2)
        context.insert(friendsMessage3)

        friendsChat.lastMessage = friendsMessage3
        
        if context.hasChanges {
            try context.save()
        }
    }
    
    @MainActor
    static func deleteAll(from context: ModelContext) throws {
        
        let messages = try context.fetch(
            FetchDescriptor<Message>()
        )

        let chats = try context.fetch(
            FetchDescriptor<Chat>()
        )

        let users = try context.fetch(
            FetchDescriptor<User>()
        )

        messages.forEach {
            context.delete($0)
        }

        chats.forEach {
            context.delete($0)
        }

        users.forEach {
            context.delete($0)
        }

        try context.save()
    }
}
