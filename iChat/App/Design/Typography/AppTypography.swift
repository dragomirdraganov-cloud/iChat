//
//  AppFont.swift
//  iChat
//
//  Created by Dragomir Draganov Karlova on 21/09/2026.
//

import SwiftUI

enum AppTypography {
    static let icon = Font.system(size: 40)
    static let largeTitle = Font.custom("Montserrat-Bold", size: 34, relativeTo: .largeTitle)
    static let headline = Font.custom("Montserrat-Bold", size: 17, relativeTo: .headline)
    static let body = Font.custom("Montserrat-Regular", size: 17, relativeTo: .body)
    static let subheadline = Font.custom("Montserrat-Regular", size: 15, relativeTo: .subheadline)
    static let footnote = Font.custom("Montserrat-Regular", size: 14, relativeTo: .footnote)
    static let caption = Font.custom("Montserrat-Regular", size: 13, relativeTo: .caption)
    static let caption2 = Font.custom("Montserrat-Regular", size: 12, relativeTo: .caption2)
}

extension Font {
    static let appIcon = AppTypography.icon
    static let appLargeTitle = AppTypography.largeTitle
    static let appHeadline = AppTypography.headline
    static let appBody = AppTypography.body
    static let appSubheadline = AppTypography.subheadline
    static let appFootnote = AppTypography.footnote
    static let appCaption = AppTypography.caption
    static let appCaption2 = AppTypography.caption2
}
