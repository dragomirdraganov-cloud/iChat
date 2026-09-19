//
//  ChatView.swift
//  iChat
//
//  Created by Dragomir Draganov Karlova on 17/09/2026.
//

import SwiftUI

struct ChatView: View {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    @FocusState private var isInputFocused: Bool
    
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
                        .transition(.offset(y: 12).combined(with: .opacity))
                    }
                }
                .animation(reduceMotion ? nil : .snappy(duration: 0.28), value: messages.map(\.id))
                .padding(.horizontal)
                .padding(.vertical, 8)
            }
            .scrollEdgeEffectStyle(.soft, for: .bottom)
            .onChange(of: messages.last?.id) { oldID, newID in
                guard oldID != newID, newID != nil else { return }

                if reduceMotion {
                    scrollToBottom(proxy)
                } else {
                    withAnimation(.easeOut(duration: 0.28)) {
                        scrollToBottom(proxy)
                    }
                }
            }
            .onChange(of: isInputFocused) { _, _ in
                scrollToBottom(proxy)
            }
            .defaultScrollAnchor(.bottom, for: .initialOffset)
            .defaultScrollAnchor(.bottom, for: .sizeChanges)
            .scrollDismissesKeyboard(.immediately)
            .contentShape(Rectangle())
            .onTapGesture {
                isInputFocused = false
            }
        }
        .navigationTitle(chat.title ?? "")
        .navigationBarTitleDisplayMode(.inline)
        .safeAreaBar(edge: .bottom, spacing: 0) {
            MessageInputView(chat: chat, currentUserID: currentUserID, inputFocus: $isInputFocused)
        }
        .toolbarVisibility(.hidden, for: .tabBar)
    }
    
    private func scrollToBottom(_ proxy: ScrollViewProxy) {
        guard let lastMessageID = messages.last?.id else { return }

        proxy.scrollTo(lastMessageID, anchor: .bottom)
    }
}
