import SwiftUI

struct StoreProductView: View {
    let listing: BookListing
    @Environment(\.dismiss) private var dismiss
    @State private var showDetails = false
    @State private var showCondition = false

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

                Text(listing.title)
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundColor(.black)
                    .padding(.leading, 8)
                    .lineLimit(1)

                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.top, 16)
            .padding(.bottom, 12)

            ScrollView {
                VStack(spacing: 0) {
                    // Cover image
                    if let coverImage = listing.coverImage {
                        Image(uiImage: coverImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 220)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 20)
                    } else {
                        Image(systemName: "book.closed")
                            .font(.system(size: 80))
                            .foregroundColor(.gray.opacity(0.4))
                            .frame(height: 220)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 20)
                    }

                    // Progress indicator
                    HStack {
                        Rectangle()
                            .fill(Color.black)
                            .frame(width: 40, height: 3)
                        Spacer()
                    }
                    .padding(.horizontal, 24)

                    // Title, Author, Price
                    VStack(alignment: .leading, spacing: 4) {
                        Text(listing.title)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.black)

                        Text(listing.author)
                            .font(.body)
                            .foregroundColor(.gray)

                        Text(listing.formattedPrice)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding(.top, 4)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 24)
                    .padding(.top, 16)
                    .padding(.bottom, 20)

                    Divider()

                    // Details accordion
                    VStack(spacing: 0) {
                        Button {
                            withAnimation {
                                showDetails.toggle()
                            }
                        } label: {
                            HStack {
                                Text("Details")
                                    .font(.body)
                                    .fontWeight(.medium)
                                    .foregroundColor(.black)
                                Spacer()
                                Image(systemName: showDetails ? "chevron.up" : "chevron.down")
                                    .font(.body)
                                    .foregroundColor(.black)
                            }
                            .padding(.horizontal, 24)
                            .padding(.vertical, 18)
                        }

                        if showDetails {
                            VStack(spacing: 0) {
                                DetailRow(label: "Publisher", value: listing.publisher)
                                DetailRow(label: "Date Published", value: listing.datePublished)
                                DetailRow(label: "Type", value: listing.attributes)
                                DetailRow(label: "Genre", value: listing.genre)
                            }
                            .padding(.bottom, 12)
                        }
                    }

                    Divider()

                    // Condition accordion
                    VStack(spacing: 0) {
                        Button {
                            withAnimation {
                                showCondition.toggle()
                            }
                        } label: {
                            HStack {
                                Text("Condition")
                                    .font(.body)
                                    .fontWeight(.medium)
                                    .foregroundColor(.black)
                                Spacer()
                                Image(systemName: showCondition ? "chevron.up" : "chevron.down")
                                    .font(.body)
                                    .foregroundColor(.black)
                            }
                            .padding(.horizontal, 24)
                            .padding(.vertical, 18)
                        }

                        if showCondition {
                            VStack(spacing: 0) {
                                DetailRow(label: "Condition", value: listing.condition)
                                DetailRow(label: "Binding", value: listing.bindingType)
                                DetailRow(label: "Jacket", value: listing.signature.isEmpty ? "N/A" : listing.signature)
                            }
                            .padding(.bottom, 12)
                        }
                    }

                    Divider()
                }
            }
        }
        .background(Color.white)
    }
}

struct DetailRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
                .font(.body)
                .foregroundColor(.gray)
            Spacer()
            Text(value.isEmpty ? "—" : value)
                .font(.body)
                .foregroundColor(.black)
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 8)
    }
}
