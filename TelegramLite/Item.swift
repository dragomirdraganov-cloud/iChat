//
//  Item.swift
//  TelegramLite
//
//  Created by Dragomir Draganov Karlova on 14/09/2026.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
