import SwiftData
import SwiftUI

struct RegisterView: View {
    private enum Field {
        case username
        case password
        case passwordConfirmation
    }

    @Environment(\.modelContext) private var modelContext
    @Environment(SessionManager.self) private var session

    @FocusState private var focusedField: Field?
    @State private var username = ""
    @State private var password = ""
    @State private var passwordConfirmation = ""
    @State private var errorMessage: String?

    var body: some View {
        VStack(spacing: 24) {
            VStack(spacing: 14) {
                AppTextField("Nombre de usuario",
                             text: $username,
                             textContentType: .username,
                             submitLabel: .next,
                             focus: $focusedField,
                             equals: .username
                ) {
                    focusedField = .password
                }

                VStack(spacing: 6) {
                    AppTextField("Contraseña",
                                 text: $password,
                                 isSecure: true,
                                 textContentType: .newPassword,
                                 submitLabel: .next,
                                 focus: $focusedField,
                                 equals: .password
                    ) {
                        focusedField = .passwordConfirmation
                    }

                    Text("Usa al menos 3 caracteres para el usuario y 6 para la contraseña.")
                        .font(.appCaption)
                        .foregroundStyle(AppColor.textSecondary)
                }

                AppTextField("Repite contraseña",
                             text: $passwordConfirmation,
                             isSecure: true,
                             textContentType: .newPassword,
                             submitLabel: .done,
                             focus: $focusedField,
                             equals: .passwordConfirmation
                ) {
                    signUp()
                }
            }

            if let errorMessage {
                withAnimation(.easeIn(duration: 0.5)) {
                    Text(errorMessage)
                        .font(.appFootnote)
                        .foregroundStyle(AppColor.error)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }

            Button("Crear cuenta", action: signUp)
                .tint(AppColor.primary)
                .foregroundStyle(AppColor.textPrimary)
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .frame(maxWidth: .infinity)
                .disabled(!canSignUp)

            Spacer()
        }
        .padding(.horizontal, 24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            AppColor.background
                .ignoresSafeArea()
                .onTapGesture {
                    focusedField = nil
                }
        }
        .navigationTitle("Crear cuenta")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var canSignUp: Bool {
        !username.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            && !password.isEmpty
            && !passwordConfirmation.isEmpty
    }

    private func signUp() {
        guard canSignUp else { return }

        guard password == passwordConfirmation else {
            errorMessage = "Las contraseñas no coinciden."
            return
        }

        do {
            try session.register(username: username, password: password, in: modelContext)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
