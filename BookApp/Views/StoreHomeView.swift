import SwiftUI

struct StoreHomeView: View {
    @Bindable var viewModel: AuthViewModel
    @State private var showShareSheet = false
    @State private var selectedListing: BookListing?

    var storeName: String {
        let name = viewModel.storeFullName.isEmpty ? "Your" : viewModel.storeFullName
        return "\(name)'s Book Shop"
    }

    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 0) {
                    // Store header
                    HStack(spacing: 12) {
                        Image(systemName: "building.2")
                            .font(.system(size: 36))
                            .foregroundColor(.black)

                        VStack(alignment: .leading, spacing: 2) {
                            Text(storeName)
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
                    .padding(.top, 24)

                    // Share Store button
                    Button {
                        showShareSheet = true
                    } label: {
                        Text("Share Store")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color.black)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 16)

                    // Book listings grid
                    if viewModel.activeListings.isEmpty {
                        VStack(spacing: 12) {
                            Text("No books listed yet")
                                .font(.body)
                                .foregroundColor(.gray)

                            Text("Sell a book from your Profile tab to see it here.")
                                .font(.caption)
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                        }
                        .padding(.top, 80)
                    } else {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(viewModel.activeListings) { listing in
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
        .sheet(isPresented: $showShareSheet) {
            ShareSheet(items: ["Check out my book store on BookApp! https://bookapp.com/store/\(viewModel.storeName.lowercased().replacingOccurrences(of: " ", with: "-"))"])
        }
        .fullScreenCover(item: $selectedListing) { listing in
            StoreProductView(listing: listing)
        }
    }
}

struct StoreListingCard: View {
    let listing: BookListing

    var body: some View {
        VStack(spacing: 8) {
            // Cover image
            if let coverImage = listing.coverImage {
                Image(uiImage: coverImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 120)
                    .clipped()
            } else {
                Image(systemName: "photo")
                    .font(.system(size: 40))
                    .foregroundColor(.gray.opacity(0.5))
                    .frame(height: 120)
                    .frame(maxWidth: .infinity)
            }

            Text(listing.title)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(.black)
                .lineLimit(1)

            Text(listing.author)
                .font(.caption)
                .foregroundColor(.gray)
                .lineLimit(1)

            Text(listing.formattedPrice)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.black)
        }
        .padding(12)
        .frame(maxWidth: .infinity)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
        )
    }
}

struct ShareSheet: UIViewControllerRepresentable {
    let items: [Any]

    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: items, applicationActivities: nil)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
