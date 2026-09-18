//
//  ChatView.swift
//  iChat
//
//  Created by Dragomir Draganov Karlova on 17/09/2026.
//

import SwiftUI

struct ChatView: View {
    let chat: Chat
    let currentUserID: UUID
    
    private var messages: [Message] {
        chat.messages.sorted {
            $0.sentAt < $1.sentAt
        }
    }
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                LazyVStack(spacing: 6) {
                    ForEach(messages) { message in
                        MessageBubbleView(
                            message: message,
                            isMine: message.sender?.id == currentUserID
                        )
                        .id(message.id)
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
            }
            .onChange(of: messages.count) {
                scrollToBottom(proxy)
            }
            .onAppear {
                scrollToBottom(proxy)
            }
        }
        .navigationTitle(chat.title ?? "")
        .navigationBarTitleDisplayMode(.inline)
        .safeAreaInset(edge: .bottom) {
            MessageInputView(chat: chat)
        }
        .toolbarVisibility(.hidden, for: .tabBar)
    }
    
    private func scrollToBottom(_ proxy: ScrollViewProxy) {
        guard let lastMessage = chat.lastMessage else {
            return
        }
        
        proxy.scrollTo(lastMessage.id, anchor: .bottom)
    }
}
