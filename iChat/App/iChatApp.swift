//
//  iChatApp.swift
//  iChat
//
//  Created by Dragomir Draganov Karlova on 14/09/2026.
//

import SwiftUI
import SwiftData

@main
struct iChatApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    @State private var session = SessionManager()

    var body: some Scene {
        WindowGroup {
            AppRootView()
                .font(.appBody)
                .environment(session)
        }
        .modelContainer(for: [
            User.self,
            Chat.self,
            Message.self
        ])
    }
}
