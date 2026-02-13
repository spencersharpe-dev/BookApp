import SwiftUI

struct ContentView: View {
    @State private var viewModel = AuthViewModel()
    @State private var showCreateAccount = false

    var body: some View {
        Group {
            if showCreateAccount {
                CreateAccountView(viewModel: viewModel, showCreateAccount: $showCreateAccount)
                    .transition(.move(edge: .trailing))
            } else {
                LoginView(viewModel: viewModel, showCreateAccount: $showCreateAccount)
                    .transition(.move(edge: .leading))
            }
        }
        .animation(.easeInOut(duration: 0.3), value: showCreateAccount)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
