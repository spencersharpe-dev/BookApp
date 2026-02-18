import SwiftUI

struct SellerStoreOverlayView: View {
    let seller: SellerStore
    @Environment(\.dismiss) private var dismiss
    @State private var selectedListing: BookListing?

    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

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
                        Image(systemName: "building.2")
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

                    // Book listings grid
                    if seller.listings.isEmpty {
                        VStack(spacing: 12) {
                            Text("No books listed yet")
                                .font(.body)
                                .foregroundColor(.gray)
                        }
                        .padding(.top, 80)
                    } else {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(seller.listings) { listing in
                                Button {
                                    selectedListing = listing
                                } label: {
                                    StoreListingCard(listing: listing)
                                }
                            }
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 20)
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
