//
//  AppRouter.swift
//  iChat
//
//  Created by Dragomir Draganov Karlova on 17/09/2026.
//

import Foundation
import Observation
import SwiftUI

enum AppRoute: Hashable {
//    case chats
    case chat(id: UUID)
}

@Observable
@MainActor
final class AppRouter {
    var path = NavigationPath()

    func navigate(to route: AppRoute) {
        withAnimation(Animation.snappy(duration: 0.32)) {
            path.append(route)
        }
    }

    func replaceStack(with route: AppRoute) {
        withAnimation(Animation.snappy(duration: 0.32)) {
            path = NavigationPath()
            path.append(route)
        }
    }

    func replaceTop(with route: AppRoute) {
        withAnimation(Animation.snappy(duration: 0.32)) {
            if !path.isEmpty {
                path.removeLast()
            }

            path.append(route)
        }
    }

    func popToRoot() {
        withAnimation(Animation.snappy(duration: 0.32)) {
            path = NavigationPath()
        }
    }
}
