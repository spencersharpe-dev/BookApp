import SwiftUI

struct ProfileView: View {
    @Bindable var viewModel: AuthViewModel
    @State private var showBookDetails = false

    private let menuItems = [
        "Profile",
        "Balance & Transfers - $380.98",
        "Active Listings",
        "Shipping",
        "Transaction History",
        "Notifications",
        "Support",
        "Agreements"
    ]

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    // User info
                    Text(viewModel.storeFullName.isEmpty ? "Stuart Sharpe" : viewModel.storeFullName)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.top, 40)
                        .padding(.horizontal, 24)

                    Text("Member since March 2020")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.horizontal, 24)
                        .padding(.top, 2)

                    // Sell Book button
                    Button {
                        showBookDetails = true
                    } label: {
                        HStack {
                            Text("Sell book")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                            Spacer()
                            Image(systemName: "book.pages")
                                .font(.title2)
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal, 24)
                        .padding(.vertical, 18)
                        .background(Color.black)
                        .cornerRadius(12)
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 20)

                    // Menu items
                    VStack(spacing: 0) {
                        ForEach(menuItems, id: \.self) { item in
                            Button {
                                // TODO: Navigate to each section
                            } label: {
                                HStack {
                                    Text(item)
                                        .font(.body)
                                        .foregroundColor(.black)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                .padding(.horizontal, 24)
                                .padding(.vertical, 18)
                            }

                            Divider()
                        }
                    }
                    .padding(.top, 16)
                }
            }
        }
        .background(Color.white)
        .fullScreenCover(isPresented: $showBookDetails) {
            BookDetailsView(viewModel: viewModel)
        }
        .onChange(of: viewModel.dismissSellFlow) { _, shouldDismiss in
            if shouldDismiss {
                showBookDetails = false
                viewModel.dismissSellFlow = false
            }
        }
    }
}
