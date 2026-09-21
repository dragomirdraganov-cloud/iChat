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
    let currentUserID: UUID
    let inputFocus: FocusState<Bool>.Binding

    private let initialHeight: CGFloat = 40

    @State private var text = ""

    var body: some View {
        HStack(alignment: .bottom, spacing: 12) {
            TextField("Mensaje", text: $text, axis: .vertical)
                .font(.appBody)
                .lineLimit(1...6)
                .padding(8)
                .frame(minHeight: initialHeight)
                .glassEffect(.regular.interactive(), in: .rect(cornerRadius: 20))
                .focused(inputFocus)
            if canSend {
                Button(action: sendMessage) {
                    Image(systemName: "paperplane.fill")
                        .font(.appBody)
                        .fontWeight(.semibold)
                        .frame(width: initialHeight, height: initialHeight)
                }
                .buttonBorderShape(.circle)
                .glassEffect(.regular.interactive(), in: .rect(cornerRadius: 30))
                .transition(
                    .scale(scale: 0.7)
                    .combined(with: .opacity)
                )
            }
        }
        .padding(8)
        .animation(.easeOut(duration: 0.28), value: canSend)
    }

    private func sendMessage() {
        let content = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !content.isEmpty else { return }

        do {
            let descriptor = FetchDescriptor(predicate: #Predicate<User> { $0.id == currentUserID })

            guard let sender = try modelContext.fetch(descriptor).first else {
                print("No se encontro el usuario actual")
                return
            }

            let message = Message(chat: chat, sender: sender, content: content)

            modelContext.insert(message)
            chat.lastMessage = message
            try modelContext.save()
            text = ""
        } catch {
            print("No se pudo guardar el mensaje: \(error)")
        }
    }

    private var canSend: Bool {
        !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
