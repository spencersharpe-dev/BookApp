import SwiftUI

struct EarningsView: View {
    @Bindable var viewModel: AuthViewModel
    @State private var showBankingSetup = false

    var formattedEarnings: String {
        String(format: "$%.2f", viewModel.totalBalance)
    }

    var hasFunds: Bool {
        viewModel.totalBalance > 0
    }

    var body: some View {
        VStack(spacing: 0) {
            // Total earnings at top
            VStack(spacing: 8) {
                Text(formattedEarnings)
                    .font(.system(size: 48, weight: .bold))
                    .foregroundColor(.black)

                Text("Total Earnings")
                    .font(.body)
                    .foregroundColor(.gray)
            }
            .padding(.top, 60)
            .padding(.bottom, 20)

            // Transfer Funds button
            Button {
                showBankingSetup = true
            } label: {
                Text("Transfer Funds")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(hasFunds ? .white : .gray)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(hasFunds ? Color.black : Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(hasFunds ? Color.clear : Color.gray.opacity(0.3), lineWidth: 2)
                    )
                    .cornerRadius(12)
            }
            .disabled(!hasFunds)
            .padding(.horizontal, 24)
            .padding(.bottom, 20)

            Divider()

            // Transaction history
            if viewModel.earningsTransactions.isEmpty {
                Spacer()
                Text("No transactions yet")
                    .font(.body)
                    .foregroundColor(.gray)
                Spacer()
            } else {
                // Column headers
                HStack {
                    Text("Description")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Amount")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .frame(width: 80, alignment: .trailing)
                    Text("Date")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .frame(width: 90, alignment: .trailing)
                }
                .padding(.horizontal, 24)
                .padding(.top, 12)
                .padding(.bottom, 8)

                Divider()

                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(viewModel.earningsTransactions) { transaction in
                            VStack(spacing: 0) {
                                HStack {
                                    Text(transaction.description)
                                        .font(.body)
                                        .foregroundColor(.black)
                                        .lineLimit(1)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    Text(transaction.formattedAmount)
                                        .font(.body)
                                        .fontWeight(.medium)
                                        .foregroundColor(transaction.amountColor)
                                        .frame(width: 80, alignment: .trailing)
                                    Text(transaction.formattedDate)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                        .frame(width: 90, alignment: .trailing)
                                }
                                .padding(.horizontal, 24)
                                .padding(.vertical, 14)

                                Divider()
                            }
                        }
                    }
                }
            }
        }
        .background(Color.white)
        .fullScreenCover(isPresented: $showBankingSetup) {
            BankingSetupView(viewModel: viewModel)
        }
    }
}
