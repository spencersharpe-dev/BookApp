import SwiftUI

struct CreateAccountView: View {
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
                    Text("Create Account")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 16)

                    Text("Register an account to sell\nbooks online")
                        .font(.body)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.top, 4)

                    // Form Fields
                    VStack(spacing: 8) {
                        UnderlineTextField(
                            placeholder: "Name",
                            text: $viewModel.registerName
                        )

                        UnderlineTextField(
                            placeholder: "Email",
                            text: $viewModel.registerEmail
                        )
                        .keyboardType(.emailAddress)

                        UnderlineTextField(
                            placeholder: "Password",
                            text: $viewModel.registerPassword,
                            isSecure: true
                        )

                        // Terms & Conditions
                        HStack(spacing: 10) {
                            Button {
                                viewModel.agreedToTerms.toggle()
                            } label: {
                                Image(systemName: viewModel.agreedToTerms ? "checkmark.square.fill" : "square")
                                    .foregroundColor(viewModel.agreedToTerms ? .accentColor : .gray)
                                    .font(.title3)
                            }

                            HStack(spacing: 4) {
                                Text("I agree to our")
                                    .foregroundColor(.white)
                                Button("Terms & Conditions") {
                                    // TODO: Open terms
                                }
                                .foregroundColor(.accentColor)
                            }
                            .font(.subheadline)

                            Spacer()
                        }
                        .padding(.top, 12)
                    }
                    .padding(.top, 32)
                    .padding(.horizontal, 24)
                }
            }

            // Bottom Section
            VStack(spacing: 16) {
                PrimaryButton(title: "Create Account") {
                    viewModel.createAccount()
                }

                HStack(spacing: 4) {
                    Text("Already have an account?")
                        .foregroundColor(.gray)
                    Button("Login") {
                        showCreateAccount = false
                    }
                    .foregroundColor(.accentColor)
                }
                .font(.subheadline)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 40)
        }
        .background(Color.black)
    }
}
