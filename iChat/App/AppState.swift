//
//  AppState.swift
//  iChat
//
//  Created by Dragomir Draganov Karlova on 17/09/2026.
//

import Observation

@Observable
@MainActor
final class AppState {
    let router: AppRouter
    var selectedTab: AppTab = .chatList

    init(router: AppRouter? = nil) {
        self.router = router ?? AppRouter()
    }

    static var preview: AppState {
        AppState()
    }
}
