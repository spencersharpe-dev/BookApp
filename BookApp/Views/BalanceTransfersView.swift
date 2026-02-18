import SwiftUI

struct BalanceTransfersView: View {
    @Bindable var viewModel: AuthViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var showBankingSetup = false

    var formattedBalance: String {
        String(format: "$%.2f", viewModel.totalBalance)
    }

    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                        .foregroundColor(.black)
                }

                Text("Balance & Transfers")
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundColor(.black)
                    .padding(.leading, 8)

                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.top, 16)
            .padding(.bottom, 12)

            Spacer()

            // Balance display
            VStack(spacing: 8) {
                Text(formattedBalance)
                    .font(.system(size: 48, weight: .bold))
                    .foregroundColor(.black)

                Text("Total Balance")
                    .font(.body)
                    .foregroundColor(.gray)
            }

            Spacer()

            // Withdraw button
            Button {
                showBankingSetup = true
            } label: {
                Text("Withdraw")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.black, lineWidth: 2)
                    )
                    .cornerRadius(12)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 40)
        }
        .background(Color.white)
        .fullScreenCover(isPresented: $showBankingSetup) {
            BankingSetupView(viewModel: viewModel)
        }
    }
}
