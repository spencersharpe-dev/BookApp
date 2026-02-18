import SwiftUI

struct ContentView: View {
    @Bindable var viewModel: AuthViewModel
    @State private var showCreateAccount = false

    var body: some View {
        if viewModel.onboardingComplete {
            MainTabView(viewModel: viewModel)
        } else if viewModel.isAuthenticated {
            SetUpStoreView(viewModel: viewModel)
        } else {
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
}
