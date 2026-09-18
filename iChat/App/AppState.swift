//
//  AppState.swift
//  iChat
//
//  Created by Dragomir Draganov Karlova on 17/09/2026.
//

import Foundation
import Observation

@Observable
@MainActor
final class AppState {
    let router: AppRouter
    
    var currentUserID: UUID? = nil
    var selectedTab: AppTab = .chatList
    
    init (router: AppRouter? = nil) {
        self.router = router ?? AppRouter()
    }
    
    static var preview: AppState {
        let appState = AppState()
        return appState
    }
}
