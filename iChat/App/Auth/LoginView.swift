import SwiftData
import SwiftUI

struct LoginView: View {
    private enum Field {
        case username
        case password
    }

    @Environment(\.modelContext) private var modelContext
    @Environment(SessionManager.self) private var session

    @FocusState private var focusedField: Field?
    @State private var username = ""
    @State private var password = ""
    @State private var errorMessage: String?

    var body: some View {
        VStack(spacing: 24) {
            Spacer()

            Image(.launchScreenIcon)
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .onLongPressGesture(minimumDuration: 1) {
                    username = "test"
                    password = "test123"
                }

            VStack(spacing: 8) {
                Text("Bienvenido a iChat")
                    .font(.appLargeTitle)
                    .foregroundStyle(AppColor.primary)

                Text("Inicia sesión para continuar")
                    .foregroundStyle(AppColor.secondary)
            }

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

                AppTextField("Contraseña",
                             text: $password,
                             isSecure: true,
                             textContentType: .password,
                             submitLabel: .done,
                             focus: $focusedField,
                             equals: .password
                ) {
                    signIn()
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

            Button("Iniciar sesión", action: signIn)
                .tint(AppColor.primary)
                .foregroundStyle(AppColor.textPrimary)
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .frame(maxWidth: .infinity)
                .disabled(!canSignIn)

            NavigationLink("Crear una cuenta") {
                RegisterView()
            }
            .foregroundStyle(AppColor.primary)

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
        .navigationBarBackButtonHidden()
    }

    private var canSignIn: Bool {
        !username.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && !password.isEmpty
    }

    private func signIn() {
        guard canSignIn else { return }

        do {
            try session.signIn(username: username, password: password, in: modelContext)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
