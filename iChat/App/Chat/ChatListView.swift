//
//  ChatListView.swift
//  iChat
//
//  Created by Dragomir Draganov Karlova on 17/09/2026.
//

import Observation
import SwiftData
import SwiftUI
import UIKit

struct ChatListView: View {
    enum Field {
        case chatBrowser
    }

    @Environment(AppState.self) private var appState
    @Environment(SessionManager.self) private var session

    @State private var showAlert = false
    @State private var searchText = ""
    @State private var isSearchPresented = false

    @FocusState private var focusedField: Field?

    @Query private var chats: [Chat]

    let viewModel: ChatListViewModel

    init(viewModel: ChatListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        @Bindable var router = appState.router

        NavigationStack(path: $router.path) {
            Group {
                if filteredChats.isEmpty && !searchText.isEmpty {
                    ContentUnavailableView.search(text: searchText)
                } else {
                    List(filteredChats) { chat in
                        NavigationLink(value: AppRoute.chat(id: chat.id)) {
                            ChatRowView(chat: chat)
                        }
                        .listRowBackground(AppColor.background)
                        .listRowSeparatorTint(AppColor.divider)
                    }
                    .listStyle(.automatic)
                    .scrollContentBackground(.hidden)
                    .scrollDismissesKeyboard(.immediately)
                    .background(AppColor.background)
//                    .simultaneousGesture(
//                        TapGesture().onEnded {
//                            focusedField = nil
//                            isSearchPresented = false
//                        }
//                    )
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(AppColor.background)
            .searchable(
                text: $searchText,
                isPresented: $isSearchPresented,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Buscar"
            )
            .searchFocused(
                $focusedField,
                equals: .chatBrowser
            )
            .tint(AppColor.primary)
            .navigationTitle("Chats")
//            .toolbarBackground(AppColor.background, for: .navigationBar)
//            .toolbarBackground(.visible, for: .navigationBar)
//            .toolbarColorScheme(.dark, for: .navigationBar)
            .navigationDestination(for: AppRoute.self) { route in
                switch route {
                case .chat(let id):
                    if let chat = chats.first(where: { $0.id == id }),
                       let currentUserID = session.currentUserID {
                        ChatView(chat: chat, currentUserID: currentUserID)
                            .onAppear {
                                searchText = ""
                            }
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
                        showAlert = true
                    }
                    .alert("Cerrar sesión", isPresented: $showAlert) {
                        Button("Cancelar", role: .cancel) {}

                        Button("Confirmar", role: .confirm) {
                            appState.router.popToRoot()
                            session.signOut()
                        }
                    } message: {
                        Text("Se va a cerrar la sesión. ¿Estás seguro de que quieres hacerlo?")
                    }
                    .labelStyle(.iconOnly)
                    .accessibilityLabel("Cerrar sesión")
                }
            }
        }
        .background {
            AppColor.background
                .ignoresSafeArea()
        }
        .navigationBarBackButtonHidden()
    }

    private var filteredChats: [Chat] {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !query.isEmpty else { return chats }

        return chats.filter { chat in
            chat.title?.localizedStandardContains(query) == true
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
