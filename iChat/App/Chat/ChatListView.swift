//
//  ChatListView.swift
//  iChat
//
//  Created by Dragomir Draganov Karlova on 17/09/2026.
//

import Observation
import SwiftUI
import SwiftData

struct ChatListView: View {
    @Environment(AppState.self) private var appState
    @Environment(\.modelContext) private var modelContext
    @Query private var chats: [Chat]
    @Query private var users: [User]
    
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
                    if let chat = chats.first(where: { $0.id == id }) {
                        ChatView(chat: chat, currentUserID: appState.currentUserID ?? UUID())
                    } else {
                        ContentUnavailableView("Chat no disponible", systemImage: "bubble.left", description: Text("El chat no existe o se ha eliminado."))
                    }
                }
                
            }
            .onAppear {
                setCurrentUserID()
            }
//            .task {
//                #if DEBUG
//                deleteDummyData()
//                insertDummyData()
//                #endif
//            }
        }
        
//        NavigationStack {
//            List(chats) { chat in
//                NavigationLink {
//                    ChatView(chat: chat)
//                } label: {
//                    ChatRowView(chat: chat)
//                }
//            }
//            .task {
//#if DEBUG
//                insertDummyData()
//#endif
//            }
//            .navigationTitle("Chats")
//        }
    }
    
    private func setCurrentUserID() {
        appState.currentUserID = users.first(where: { $0.username == "Drago" })?.id
    }
    
    private func insertDummyData() {
        do {
            try DummyData.insertIfNeeded(into: modelContext, appState: appState)
        } catch {
            print("Error inserting dummy data: \(error)")
        }
    }
    
    private func deleteDummyData() {
        do {
            try DummyData.deleteAll(from: modelContext)
        } catch {
            print("Error deleting all data from dummy data: \(error)")
        }
    }
}

#Preview {
    NavigationStack {
        ChatListView(viewModel: ChatListViewModel())
        .environment(AppState.preview)
    }
}
