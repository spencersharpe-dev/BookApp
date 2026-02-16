import SwiftUI

struct PlaidIntroView: View {
    @Bindable var viewModel: AuthViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var showBankSelection = false

    var body: some View {
        VStack(spacing: 0) {
            // Top bar with divider
            Divider()

            VStack(spacing: 0) {
                // Close button
                HStack {
                    Spacer()
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.title2)
                            .fontWeight(.medium)
                            .foregroundColor(.black)
                    }
                }
                .padding(.top, 24)
                .padding(.trailing, 24)

                Spacer()

                // Envelope icon
                Image(systemName: "envelope.badge.shield.half.filled")
                    .font(.system(size: 80))
                    .foregroundColor(.black)

                // Title
                HStack(spacing: 0) {
                    Text("This application uses ")
                        .font(.body)
                        .foregroundColor(.black)
                    Text("Plaid")
                        .font(.body)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    Text(" to")
                        .font(.body)
                        .foregroundColor(.black)
                }
                .padding(.top, 24)

                Text("link your bank")
                    .font(.body)
                    .foregroundColor(.black)

                // Features
                VStack(alignment: .leading, spacing: 20) {
                    HStack(alignment: .top, spacing: 16) {
                        Image(systemName: "checkmark")
                            .foregroundColor(.black)
                            .fontWeight(.medium)
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Secure")
                                .font(.headline)
                                .foregroundColor(.black)
                            Text("Encryption helps protect your personal financial data")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }

                    HStack(alignment: .top, spacing: 16) {
                        Image(systemName: "checkmark")
                            .foregroundColor(.black)
                            .fontWeight(.medium)
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Private")
                                .font(.headline)
                                .foregroundColor(.black)
                            Text("Your credentials will never be made accessible to this application")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding(.top, 40)
                .padding(.horizontal, 40)

                Spacer()

                // Privacy policy text
                HStack(spacing: 4) {
                    Text("By selecting \"Continue\" you agree to the")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Button("Plaid End User Privacy Policy") {
                        // TODO: Open privacy policy
                    }
                    .font(.caption)
                    .foregroundColor(.blue)
                }
                .padding(.horizontal, 24)

                // Continue button
                Button {
                    showBankSelection = true
                } label: {
                    Text("Continue")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(Color.black)
                        .cornerRadius(12)
                }
                .padding(.horizontal, 24)
                .padding(.top, 12)
                .padding(.bottom, 40)
            }
        }
        .background(Color.white)
        .fullScreenCover(isPresented: $showBankSelection) {
            PlaidBankSelectionView(viewModel: viewModel)
        }
    }
}
