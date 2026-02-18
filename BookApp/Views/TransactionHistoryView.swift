import SwiftUI

struct TransactionHistoryView: View {
    @Bindable var viewModel: AuthViewModel
    @Environment(\.dismiss) private var dismiss

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

                Text("Transaction History")
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundColor(.black)
                    .padding(.leading, 8)

                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.top, 16)
            .padding(.bottom, 12)

            if viewModel.activeListings.isEmpty {
                Spacer()
                Text("No transactions yet")
                    .font(.body)
                    .foregroundColor(.gray)
                Spacer()
            } else {
                // Column headers
                HStack {
                    Text("Type")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .frame(width: 100, alignment: .leading)
                    Text("Order Number")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .frame(width: 90, alignment: .leading)
                    Text("Amount")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .frame(width: 70, alignment: .trailing)
                    Text("Date Sold")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding(.horizontal, 24)
                .padding(.top, 12)
                .padding(.bottom, 8)

                Divider()

                // Transaction rows
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(viewModel.activeListings) { listing in
                            VStack(spacing: 0) {
                                HStack {
                                    Text(listing.title)
                                        .font(.body)
                                        .foregroundColor(.black)
                                        .lineLimit(1)
                                        .frame(width: 100, alignment: .leading)
                                    Text(listing.orderNumber)
                                        .font(.body)
                                        .foregroundColor(.black)
                                        .frame(width: 90, alignment: .leading)
                                    Text(listing.formattedPrice)
                                        .font(.body)
                                        .foregroundColor(.black)
                                        .frame(width: 70, alignment: .trailing)
                                    Text(listing.formattedDateSold)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                        .frame(maxWidth: .infinity, alignment: .trailing)
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
    }
}
