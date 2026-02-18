import SwiftUI

struct ProfileView: View {
    @Bindable var viewModel: AuthViewModel
    @State private var showBookDetails = false
    @State private var showProfileInfo = false
    @State private var showBalanceTransfers = false
    @State private var showActiveListings = false
    @State private var showReturnAddress = false
    @State private var showTransactionHistory = false
    @State private var showNotifications = false
    @State private var showSupport = false
    @State private var showAgreements = false

    var balanceLabel: String {
        String(format: "Balance & Transfers - $%.2f", viewModel.totalBalance)
    }

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
                        ProfileMenuItem(title: "Profile") {
                            showProfileInfo = true
                        }
                        ProfileMenuItem(title: balanceLabel) {
                            showBalanceTransfers = true
                        }
                        ProfileMenuItem(title: "Active Listings") {
                            showActiveListings = true
                        }
                        ProfileMenuItem(title: "Return Address") {
                            showReturnAddress = true
                        }
                        ProfileMenuItem(title: "Transaction History") {
                            showTransactionHistory = true
                        }
                        ProfileMenuItem(title: "Notifications") {
                            showNotifications = true
                        }
                        ProfileMenuItem(title: "Support") {
                            showSupport = true
                        }
                        ProfileMenuItem(title: "Agreements") {
                            showAgreements = true
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
        .fullScreenCover(isPresented: $showProfileInfo) {
            ProfileInfoView(viewModel: viewModel)
        }
        .fullScreenCover(isPresented: $showBalanceTransfers) {
            BalanceTransfersView(viewModel: viewModel)
        }
        .fullScreenCover(isPresented: $showActiveListings) {
            ActiveListingsView(viewModel: viewModel)
        }
        .fullScreenCover(isPresented: $showReturnAddress) {
            ReturnAddressView(viewModel: viewModel)
        }
        .fullScreenCover(isPresented: $showTransactionHistory) {
            TransactionHistoryView(viewModel: viewModel)
        }
        .fullScreenCover(isPresented: $showNotifications) {
            NotificationsView(viewModel: viewModel)
        }
        .fullScreenCover(isPresented: $showSupport) {
            SupportListView(viewModel: viewModel)
        }
        .fullScreenCover(isPresented: $showAgreements) {
            AgreementsView(viewModel: viewModel)
        }
        .onChange(of: viewModel.dismissSellFlow) { _, shouldDismiss in
            if shouldDismiss {
                showBookDetails = false
                viewModel.dismissSellFlow = false
            }
        }
    }
}

struct ProfileMenuItem: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
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
