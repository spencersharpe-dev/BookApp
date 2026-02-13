import SwiftUI

struct ForgotPasswordView: View {
    @Bindable var viewModel: AuthViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 0) {
            // Close Button
            HStack {
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(.black)
                }
            }
            .padding(.top, 20)
            .padding(.trailing, 24)

            // Lock Icon
            Image(systemName: "lock.rotation")
                .font(.system(size: 56))
                .foregroundColor(.black)
                .padding(.top, 20)

            // Title
            Text("Forgot Password")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.top, 20)

            Text("Enter your email and we'll send\na recovery email to your inbox")
                .font(.body)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.top, 8)

            // Email Field
            UnderlineTextFieldLight(
                placeholder: "Email",
                text: $viewModel.forgotPasswordEmail
            )
            .keyboardType(.emailAddress)
            .padding(.horizontal, 24)
            .padding(.top, 40)

            Spacer()

            // Continue Button
            PrimaryButton(title: "Continue", style: .dark) {
                viewModel.resetPassword()
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 40)
        }
        .background(Color.white)
        .presentationDetents([.large])
    }
}
