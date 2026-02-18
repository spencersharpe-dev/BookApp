import SwiftUI

struct BankingSetupView: View {
    @Bindable var viewModel: AuthViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var showPlaidFlow = false

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

            Divider()

            // Select Account label
            Text("Select Account")
                .font(.subheadline)
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 24)
                .padding(.top, 12)
                .padding(.bottom, 8)

            Divider()

            // Linked banks list
            VStack(spacing: 0) {
                ForEach(viewModel.linkedBanks) { bank in
                    Button {
                        viewModel.selectedBankId = bank.id
                    } label: {
                        HStack(spacing: 12) {
                            // Bank icon
                            Image(systemName: bank.icon)
                                .font(.title3)
                                .foregroundColor(.blue)
                                .frame(width: 32, height: 32)

                            Text(bank.name)
                                .font(.body)
                                .foregroundColor(.black)

                            Spacer()

                            // Selection indicator
                            if viewModel.selectedBankId == bank.id {
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.title3)
                                    .foregroundColor(.green)
                            } else {
                                Image(systemName: "checkmark.circle")
                                    .font(.title3)
                                    .foregroundColor(.gray.opacity(0.4))
                            }
                        }
                        .padding(.horizontal, 24)
                        .padding(.vertical, 14)
                    }

                    Divider()
                }

                // Add Account button
                Button {
                    showPlaidFlow = true
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
            }

            Spacer()

            // Transfer Funds bar at bottom
            if viewModel.selectedBankId != nil {
                HStack {
                    Text("Transfer Funds")
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundColor(.black)
                    Spacer()
                    Text(formattedBalance)
                        .font(.body)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 18)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
            } else if !viewModel.linkedBanks.isEmpty {
                HStack {
                    Text("Transfer Funds")
                        .font(.body)
                        .foregroundColor(.gray)
                    Spacer()
                    Text(formattedBalance)
                        .font(.body)
                        .foregroundColor(.gray.opacity(0.5))
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 18)
                .background(Color.gray.opacity(0.05))
                .cornerRadius(12)
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
            }
        }
        .background(Color.white)
        .fullScreenCover(isPresented: $showPlaidFlow) {
            PlaidIntroView(viewModel: viewModel)
        }
    }
}
