//
//  ChatListView.swift
//  iChat
//
//  Created by Dragomir Draganov Karlova on 17/09/2026.
//

import Observation
import SwiftData
import SwiftUI

struct ChatListView: View {
    @Environment(AppState.self) private var appState
    @Environment(SessionManager.self) private var session

    @Query private var chats: [Chat]

    let viewModel: ChatListViewModel

    init(viewModel: ChatListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        @Bindable var router = appState.router

        NavigationStack(path: $router.path) {
            List(chats) { chat in
                NavigationLink(value: AppRoute.chat(id: chat.id)) {
                    ChatRowView(chat: chat)
                }
            }
            .navigationTitle("Chats")
            .navigationDestination(for: AppRoute.self) { route in
                switch route {
                case .chat(let id):
                    if let chat = chats.first(where: { $0.id == id }),
                       let currentUserID = session.currentUserID {
                        ChatView(chat: chat, currentUserID: currentUserID)
                    } else {
                        ContentUnavailableView(
                            "Chat no disponible",
                            systemImage: "bubble.left",
                            description: Text("El chat no existe o se ha eliminado.")
                        )
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Cerrar sesión", systemImage: "rectangle.portrait.and.arrow.right") {
                        appState.router.popToRoot()
                        session.signOut()
                    }
                    .labelStyle(.iconOnly)
                    .accessibilityLabel("Cerrar sesión")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        ChatListView(viewModel: ChatListViewModel())
            .environment(AppState.preview)
            .environment(SessionManager())
            .modelContainer(for: [User.self, Chat.self, Message.self], inMemory: true)
    }
}
