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



        Form {
            Section {
                TextField("Nombre de usuario", text: $username)
                    .textContentType(.username)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .submitLabel(.next)
                    .focused($focusedField, equals: .username)
                    .onSubmit {
                        focusedField = .password
                    }

                SecureField("Contraseña", text: $password)
                    .textContentType(.newPassword)
                    .submitLabel(.next)
                    .focused($focusedField, equals: .password)
                    .onSubmit {
                        focusedField = .passwordConfirmation
                    }

                SecureField("Repite la contraseña", text: $passwordConfirmation)
                    .textContentType(.newPassword)
                    .submitLabel(.done)
                    .focused($focusedField, equals: .passwordConfirmation)
                    .onSubmit(register)
            } footer: {
                Text("Usa al menos 3 caracteres para el usuario y 6 para la contraseña.")
            }

            if let errorMessage {
                Section {
                    Text(errorMessage)
                        .foregroundStyle(.red)
                }
            }

            Section {
                Button("Crear cuenta", action: register)
                    .frame(maxWidth: .infinity)
                    .disabled(!canRegister)
            }
        }
        .navigationTitle("Crear cuenta")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var canRegister: Bool {
        !username.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            && !password.isEmpty
            && !passwordConfirmation.isEmpty
    }

    private func register() {
        guard canRegister else { return }

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
