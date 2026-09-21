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
                .fill(AppColor.surface.opacity(0.3))
                .frame(width: 50, height: 50)
                .overlay {
                    Image(systemName: "person.fill")
                        .foregroundStyle(AppColor.textSecondary)
                }
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(chat.title ?? "")
                        .font(.appHeadline)

                    Spacer()

                    Text(chat.lastMessage?.sentAt ?? .now, style: .time)
                        .font(.appCaption)
                        .foregroundStyle(AppColor.textSecondary)
                }

                HStack(spacing: 4) {
                    Text("\(chat.lastMessage?.sender?.username ?? ""):")
                        .fontWeight(.medium)
                    Text(chat.lastMessage?.content ?? "")
                        .foregroundStyle(AppColor.textSecondary)
                        .lineLimit(1)
                }
                .font(.appSubheadline)
            }
        }
        .padding(.vertical, 4)
    }
}
