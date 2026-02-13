import SwiftUI

struct LoginView: View {
    @Bindable var viewModel: AuthViewModel
    @Binding var showCreateAccount: Bool

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 0) {
                    // Book Icon
                    Image(systemName: "books.vertical")
                        .font(.system(size: 60))
                        .foregroundColor(.white)
                        .padding(.top, 40)

                    // Title
                    Text("Login")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 16)

                    Text("Welcome back!")
                        .font(.body)
                        .foregroundColor(.gray)
                        .padding(.top, 4)

                    // Form Fields
                    VStack(spacing: 8) {
                        UnderlineTextField(
                            placeholder: "Email",
                            text: $viewModel.loginEmail
                        )
                        .keyboardType(.emailAddress)

                        UnderlineTextField(
                            placeholder: "Password",
                            text: $viewModel.loginPassword,
                            isSecure: true,
                            trailingContent: AnyView(
                                Button("Forgot password?") {
                                    viewModel.showForgotPassword = true
                                }
                                .font(.footnote)
                                .foregroundColor(.accentColor)
                            )
                        )
                    }
                    .padding(.top, 40)
                    .padding(.horizontal, 24)
                }
            }

            // Bottom Section
            VStack(spacing: 16) {
                PrimaryButton(title: "Login") {
                    viewModel.login()
                }

                HStack(spacing: 4) {
                    Text("Don't have an account?")
                        .foregroundColor(.gray)
                    Button("Create account") {
                        showCreateAccount = true
                    }
                    .foregroundColor(.accentColor)
                }
                .font(.subheadline)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 40)
        }
        .background(Color.black)
        .sheet(isPresented: $viewModel.showForgotPassword) {
            ForgotPasswordView(viewModel: viewModel)
        }
    }
}
