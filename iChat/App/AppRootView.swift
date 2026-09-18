//
//  AppRootView.swift
//  iChat
//
//  Created by Dragomir Draganov Karlova on 17/09/2026.
//

import SwiftUI

struct AppRootView: View {
    @State private var appState = AppState()
    
    
    var body: some View {
        NavigationTabView()
            .environment(appState)
//        @Bindable var router = appState.router
//        
//        ZStack {
//            NavigationStack(path: $router.path) {
//                Group {
//                    NavigationTabView()
//                }
//                .navigationDestination(for: AppRoute.self) { route in
//                    destination(for: route)
//                }
//            }
//        }
//        .environment(appState)
    }
    
//    @ViewBuilder
//    private func destination(for route: AppRoute) -> some View {
//        switch route {
//        case .chats:
//            ChatListView(viewModel: ChatListViewModel())
//        }
//    }
}

#Preview {
    AppRootView()
}
