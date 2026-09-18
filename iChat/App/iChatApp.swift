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
    
    var body: some Scene {
        WindowGroup {
            AppRootView()
        }
        .modelContainer(for: [
            User.self,
            Chat.self,
            Message.self
        ])
    }
}
