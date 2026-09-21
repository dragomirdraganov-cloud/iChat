import SwiftData
import SwiftUI

struct AuthView: View {
    var body: some View {
        NavigationStack {
            LoginView()
        }
    }
}

#Preview {
    AuthView()
        .environment(SessionManager())
        .modelContainer(for: User.self, inMemory: true)
}
