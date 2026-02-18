import SwiftUI

struct SellerStoreOverlayView: View {
    let seller: SellerStore
    @Environment(\.dismiss) private var dismiss
    @State private var selectedListing: BookListing?

    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var genreGroups: [(genre: String, listings: [BookListing])] {
        var grouped: [String: [BookListing]] = [:]
        for listing in seller.listings {
            let genre = listing.genre.isEmpty ? "Other" : listing.genre
            grouped[genre, default: []].append(listing)
        }
        return grouped
            .map { (genre: $0.key, listings: $0.value) }
            .sorted { $0.genre < $1.genre }
    }

    var body: some View {
        VStack(spacing: 0) {
            // Header with X button
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
            .padding(.horizontal, 24)
            .padding(.top, 16)

            ScrollView {
                VStack(spacing: 0) {
                    // Store header
                    HStack(spacing: 12) {
                        Image(systemName: "books.vertical")
                            .font(.system(size: 36))
                            .foregroundColor(.black)

                        VStack(alignment: .leading, spacing: 2) {
                            Text(seller.storeName)
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.black)

                            Text("Established March 2020")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }

                        Spacer()
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 8)

                    // Book listings grouped by genre
                    if seller.listings.isEmpty {
                        VStack(spacing: 12) {
                            Text("No books listed yet")
                                .font(.body)
                                .foregroundColor(.gray)
                        }
                        .padding(.top, 80)
                    } else {
                        ForEach(genreGroups, id: \.genre) { group in
                            VStack(alignment: .leading, spacing: 0) {
                                Text(group.genre)
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                                    .padding(.horizontal, 24)
                                    .padding(.top, 24)
                                    .padding(.bottom, 12)

                                LazyVGrid(columns: columns, spacing: 16) {
                                    ForEach(group.listings) { listing in
                                        Button {
                                            selectedListing = listing
                                        } label: {
                                            StoreListingCard(listing: listing)
                                        }
                                    }
                                }
                                .padding(.horizontal, 24)
                            }
                        }
                        .padding(.bottom, 24)
                    }
                }
            }
        }
        .background(Color.white)
        .fullScreenCover(item: $selectedListing) { listing in
            BuyOfferProductView(listing: listing, sellerName: seller.ownerName)
        }
    }
}
