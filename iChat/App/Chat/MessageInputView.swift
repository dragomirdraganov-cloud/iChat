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
    
    @State private var text = ""
    
    var body: some View {
        HStack(spacing: 12) {
            TextField("Mensaje", text: $text, axis: .vertical)
                .font(.body)
                .lineLimit(6)
                .padding(12)
                .glassEffect(.regular.interactive(), in: .rect(cornerRadius: 20))
                .focused(inputFocus)
            if !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                Button(action: sendMessage) {
                    Image(systemName: "paperplane.fill")
                        .font(.body)
                        .fontWeight(.semibold)
                        .frame(width: 30, height: 30)
                }
                .buttonBorderShape(.circle)
                .buttonStyle(.glassProminent)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
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
}
