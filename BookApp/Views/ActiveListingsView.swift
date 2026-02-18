import SwiftUI

struct ActiveListingsView: View {
    @Bindable var viewModel: AuthViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var showSellBook = false

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

                Text("Active Listings")
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

            if viewModel.activeListings.isEmpty {
                // Empty state
                Spacer()

                VStack(spacing: 16) {
                    Image(systemName: "book.closed")
                        .font(.system(size: 48))
                        .foregroundColor(.gray.opacity(0.4))

                    Text("You have no active listings")
                        .font(.body)
                        .foregroundColor(.gray)
                }

                Spacer()

                Button {
                    showSellBook = true
                } label: {
                    Text("Sell your first book!")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(Color.black)
                        .cornerRadius(12)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
            } else {
                // Listings
                List {
                    ForEach(viewModel.activeListings) { listing in
                        ListingRow(listing: listing)
                            .listRowInsets(EdgeInsets())
                            .listRowSeparator(.hidden)
                            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                Button(role: .destructive) {
                                    withAnimation {
                                        viewModel.deleteListing(listing)
                                    }
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }

                                Button {
                                    withAnimation {
                                        viewModel.snoozeListing(listing)
                                    }
                                } label: {
                                    Label("Snooze", systemImage: "moon.zzz")
                                }
                                .tint(.orange)
                            }
                    }
                }
                .listStyle(.plain)
            }
        }
        .background(Color.white)
        .fullScreenCover(isPresented: $showSellBook) {
            BookDetailsView(viewModel: viewModel)
        }
        .onChange(of: viewModel.dismissSellFlow) { _, shouldDismiss in
            if shouldDismiss {
                showSellBook = false
                viewModel.dismissSellFlow = false
            }
        }
    }
}

struct ListingRow: View {
    let listing: BookListing

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 16) {
                // Book thumbnail placeholder
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    .frame(width: 56, height: 56)
                    .overlay(
                        Image(systemName: "book.closed")
                            .foregroundColor(.gray.opacity(0.4))
                    )

                VStack(alignment: .leading, spacing: 4) {
                    Text(listing.title)
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundColor(.black)

                    Text(listing.author)
                        .font(.caption)
                        .foregroundColor(.gray)
                }

                Spacer()

                VStack(alignment: .trailing, spacing: 4) {
                    Text(listing.formattedPrice)
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundColor(.black)

                    if listing.isSnoozed {
                        Text("Snoozed")
                            .font(.caption2)
                            .foregroundColor(.orange)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(Color.orange.opacity(0.1))
                            .cornerRadius(4)
                    }
                }
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 14)

            Divider()
        }
        .background(Color.white)
    }
}
