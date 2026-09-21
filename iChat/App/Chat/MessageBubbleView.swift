//
//  MessageBubbleView.swift
//  iChat
//
//  Created by Dragomir Draganov Karlova on 17/09/2026.
//

import SwiftUI

struct MessageBubbleView: View {
    let message: Message
    let isMine: Bool

    var body: some View {
        HStack {
            if isMine {
                Spacer(minLength: 60)
            }

            VStack(alignment: isMine ? .trailing : .leading, spacing: 4) {
                Text(message.content)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(isMine ? Color.blue : Color.gray.opacity(0.2))
                    }
                    .foregroundStyle(isMine ? Color.white : Color.primary)
                Text(message.sentAt, format: .dateTime.hour().minute())
                    .font(.appCaption2)
                    .foregroundStyle(.secondary)
            }

            if !isMine {
                Spacer(minLength: 60)
            }
        }
    }
}
