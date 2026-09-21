//
//  AppColor.swift
//  iChat
//
//  Created by Dragomir Draganov Karlova on 21/09/2026.
//

import SwiftUI

enum AppColor {
    static let primary = Color("AccentColor")
    static let secondary = Color("TextColor")
    static let background = Color("BackgroundColor")
    static let surface = Color("SurfaceColor")
    static let error = Color("ErrorColor")

    static let textPrimary = secondary
    static let textSecondary = secondary.opacity(0.7)

    static let messageSent = primary
    static let messageReceived = surface

    static let divider = secondary.opacity(0.15)
}
