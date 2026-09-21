//
//  AppRootView.swift
//  iChat
//
//  Created by Dragomir Draganov Karlova on 17/09/2026.
//

import SwiftData
import SwiftUI

struct AppRootView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(SessionManager.self) private var session

    @State private var appState = AppState()

    var body: some View {
        Group {
            switch session.state {
            case .restoring:
                ProgressView("Cargando sesión…")
            case .signedOut:
                AuthView()
                    .transition(.opacity)
            case .signedIn:
                NavigationTabView()
                    .environment(appState)
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.2), value: session.state)
        .task {
            session.restoreSession(in: modelContext)
        }
    }
}

#Preview {
    AppRootView()
        .environment(SessionManager())
        .modelContainer(for: [User.self, Chat.self, Message.self], inMemory: true)
}
