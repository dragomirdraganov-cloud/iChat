//
//  TabView.swift
//  iChat
//
//  Created by Dragomir Draganov Karlova on 17/09/2026.
//

import SwiftData
import SwiftUI

struct NavigationTabView: View {
    @Environment(AppState.self) private var appState
    @State private var chatListViewModel: ChatListViewModel

    init() {
        _chatListViewModel = State(initialValue: ChatListViewModel())
    }

    var body: some View {
        Group {
            TabView(selection: selectedTab) {
                Tab(AppTab.chatList.title, systemImage: AppTab.chatList.systemImage, value: AppTab.chatList) {
                    tabContent(for: .chatList)
                }
            }
            .tabViewStyle(.sidebarAdaptable)
            .tint(AppColor.secondary)
//            .toolbarBackground(AppColor.background, for: .tabBar)
//            .toolbarBackground(.visible, for: .tabBar)
//            .toolbarColorScheme(.dark, for: .tabBar)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppColor.background)
    }

    @ViewBuilder
    private func tabContent(for tab: AppTab) -> some View {
        switch tab {
        case .chatList:
            ChatListView(viewModel: chatListViewModel)
                .background(AppColor.background)
        }
    }

    private var selectedTab: Binding<AppTab> {
        Binding {
            appState.selectedTab
        } set: { tab in
            appState.selectedTab = tab
        }
    }
}

enum AppTab: Hashable, CaseIterable {
    case chatList

    var title: String {
        switch self {
        case .chatList: "Chats"
        }
    }

    var systemImage: String {
        switch self {
        case .chatList: "bubble.left.and.text.bubble.right"
        }
    }

    var selectedSystemImage: String {
        switch self {
        case .chatList: "bubble.left.and.text.bubble.right"
        }
    }
}

#Preview {
    NavigationStack {
        NavigationTabView()
            .environment(AppState.preview)
            .environment(SessionManager())
            .modelContainer(for: [User.self, Chat.self, Message.self], inMemory: true)
    }
}
