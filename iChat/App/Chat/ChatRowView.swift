//
//  ChatRowView.swift
//  iChat
//
//  Created by Dragomir Draganov Karlova on 17/09/2026.
//

import SwiftUI

struct ChatRowView: View {
    let chat: Chat
    
    var body: some View {
        HStack(spacing: 12) {
            Circle()
                .fill(Color.gray.opacity(0.3))
                .frame(width: 50, height: 50)
                .overlay {
                    Image(systemName: "person.fill")
                        .foregroundStyle(.secondary)
                }
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(chat.title ?? "")
                        .font(.headline)
                    
                    Spacer()
                    
                    Text(chat.lastMessage?.sentAt ?? .now, style: .time)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                
                HStack(spacing: 4) {
                    Text("\(chat.lastMessage?.sender?.username ?? ""):")
                        .fontWeight(.medium)
                    Text(chat.lastMessage?.content ?? "")
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }
                .font(.subheadline)
            }
        }
        .padding(.vertical, 4)
    }
}
