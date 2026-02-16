import SwiftUI

struct LinkBankAccountView: View {
    @Bindable var viewModel: AuthViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var showPlaidIntro = false
    @State private var showOnboarding = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Link bank account")
                .font(.title2)
                .fontWeight(.medium)
                .foregroundColor(.black)
                .padding(.top, 40)
                .padding(.horizontal, 24)

            Divider()
                .padding(.top, 8)

            // Add Account button
            Button {
                showPlaidIntro = true
            } label: {
                HStack {
                    Text("Add Account")
                        .font(.body)
                        .foregroundColor(.black)
                    Spacer()
                    Image(systemName: "plus")
                        .foregroundColor(.black)
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 14)
            }

            Divider()

            Spacer()

            // Bottom navigation
            HStack {
                Button {
                    dismiss()
                } label: {
                    HStack(spacing: 8) {
                        Image(systemName: "arrow.left")
                            .font(.title2)
                        Text("Back")
                            .font(.title2)
                            .fontWeight(.medium)
                            .italic()
                    }
                    .foregroundColor(.black)
                }

                Spacer()

                Button {
                    showOnboarding = true
                } label: {
                    HStack(spacing: 8) {
                        Text("Skip")
                            .font(.title2)
                            .fontWeight(.medium)
                            .italic()
                        Image(systemName: "arrow.right")
                            .font(.title2)
                    }
                    .foregroundColor(.black)
                }
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 40)
        }
        .background(Color.white)
        .fullScreenCover(isPresented: $showPlaidIntro) {
            PlaidIntroView(viewModel: viewModel)
        }
        .fullScreenCover(isPresented: $showOnboarding) {
            OnboardingView(viewModel: viewModel)
        }
    }
}
