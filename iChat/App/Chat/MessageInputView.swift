//
//  MessageInputView.swift
//  iChat
//
//  Created by Dragomir Draganov Karlova on 17/09/2026.
//

import SwiftUI
import SwiftData

struct MessageInputView: View {
    @Environment(\.modelContext) private var modelContext
    let chat: Chat
    @State private var text = ""
    
    var body: some View {
        HStack(spacing: 12) {
            TextField("Mensaje", text: $text, axis: .vertical)
                .font(.body)
                .lineLimit(6)
                .padding(12)
                .glassEffect(.regular.interactive(), in: .rect(cornerRadius: 25))
            
            Button(action: sendMessage) {
                Image(systemName: "paperplane.fill")
                    .font(.body)
                    .fontWeight(.semibold)
                    .frame(width: 25, height: 25)
            }
            .background(Color.primary)
            .buttonStyle(.glassProminent)
            .buttonBorderShape(.circle)
            .disabled(
                text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            )
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
    
    private func sendMessage() {

    }
}

#Preview {
    MessageInputView(chat: Chat(chatType: .direct, title: "Test"))
}
