import SwiftUI

struct ListingsTabView: View {
    @Bindable var viewModel: AuthViewModel
    @State private var selectedGenreFilter: String? = nil
    @State private var showGenreFilter = false
    @State private var selectedListing: BookListing?
    @State private var listingToSnooze: BookListing?
    @State private var listingToDelete: BookListing?

    var availableGenres: [String] {
        let genres = Set(viewModel.activeListings.map { $0.genre.isEmpty ? "Other" : $0.genre })
        return genres.sorted()
    }

    var filteredListings: [BookListing] {
        guard let filter = selectedGenreFilter else {
            return viewModel.activeListings
        }
        return viewModel.activeListings.filter {
            let genre = $0.genre.isEmpty ? "Other" : $0.genre
            return genre == filter
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Text("Listings")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.black)

                Spacer()

                if !viewModel.activeListings.isEmpty {
                    Button {
                        showGenreFilter = true
                    } label: {
                        HStack(spacing: 4) {
                            Image(systemName: "line.3.horizontal.decrease")
                                .font(.body)
                            Text(selectedGenreFilter ?? "All Genres")
                                .font(.subheadline)
                        }
                        .foregroundColor(.black)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                    }
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 16)
            .padding(.bottom, 12)

            Divider()

            if viewModel.activeListings.isEmpty {
                Spacer()
                VStack(spacing: 16) {
                    Image(systemName: "book.closed")
                        .font(.system(size: 48))
                        .foregroundColor(.gray.opacity(0.4))

                    Text("No listings yet")
                        .font(.body)
                        .foregroundColor(.gray)

                    Text("Sell a book from your Profile tab to see it here.")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                }
                Spacer()
            } else if filteredListings.isEmpty {
                Spacer()
                Text("No listings in this genre")
                    .font(.body)
                    .foregroundColor(.gray)
                Spacer()
            } else {
                List {
                    ForEach(filteredListings) { listing in
                        Button {
                            selectedListing = listing
                        } label: {
                            ListingsTabRow(listing: listing)
                        }
                        .listRowInsets(EdgeInsets())
                        .listRowSeparator(.hidden)
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button(role: .destructive) {
                                listingToDelete = listing
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }

                            Button {
                                listingToSnooze = listing
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
        .sheet(isPresented: $showGenreFilter) {
            GenreFilterSheet(
                genres: availableGenres,
                selectedGenre: $selectedGenreFilter
            )
        }
        .fullScreenCover(item: $selectedListing) { listing in
            ListingDetailView(viewModel: viewModel, listing: listing)
        }
        .alert("Snooze Listing", isPresented: Binding(
            get: { listingToSnooze != nil },
            set: { if !$0 { listingToSnooze = nil } }
        )) {
            Button("Cancel", role: .cancel) {
                listingToSnooze = nil
            }
            Button("Snooze") {
                if let listing = listingToSnooze {
                    withAnimation {
                        viewModel.snoozeListing(listing)
                    }
                }
                listingToSnooze = nil
            }
        } message: {
            Text("Are you sure you want to snooze this listing? Snoozing a listing will deactivate the listing for 48 hours.")
        }
        .alert("Delete Listing", isPresented: Binding(
            get: { listingToDelete != nil },
            set: { if !$0 { listingToDelete = nil } }
        )) {
            Button("Cancel", role: .cancel) {
                listingToDelete = nil
            }
            Button("Delete", role: .destructive) {
                if let listing = listingToDelete {
                    withAnimation {
                        viewModel.deleteListing(listing)
                    }
                }
                listingToDelete = nil
            }
        } message: {
            Text("Are you sure you want to delete this listing?")
        }
    }
}

struct ListingsTabRow: View {
    let listing: BookListing

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 16) {
                if let coverImage = listing.coverImage {
                    Image(uiImage: coverImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 56, height: 56)
                        .cornerRadius(8)
                        .clipped()
                } else {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        .frame(width: 56, height: 56)
                        .overlay(
                            Image(systemName: "book.closed")
                                .foregroundColor(.gray.opacity(0.4))
                        )
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text(listing.title)
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundColor(.black)

                    Text(listing.author)
                        .font(.caption)
                        .foregroundColor(.gray)

                    Text(listing.genre.isEmpty ? "Other" : listing.genre)
                        .font(.caption2)
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

struct GenreFilterSheet: View {
    let genres: [String]
    @Binding var selectedGenre: String?
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Filter by Genre")
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundColor(.black)
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
            .padding(.top, 20)
            .padding(.bottom, 12)

            Divider()

            ScrollView {
                VStack(spacing: 0) {
                    // All Genres option
                    Button {
                        selectedGenre = nil
                        dismiss()
                    } label: {
                        HStack {
                            Text("All Genres")
                                .font(.body)
                                .foregroundColor(.black)
                            Spacer()
                            if selectedGenre == nil {
                                Image(systemName: "checkmark")
                                    .font(.body)
                                    .foregroundColor(.black)
                            }
                        }
                        .padding(.horizontal, 24)
                        .padding(.vertical, 14)
                    }

                    Divider()

                    ForEach(genres, id: \.self) { genre in
                        Button {
                            selectedGenre = genre
                            dismiss()
                        } label: {
                            HStack {
                                Text(genre)
                                    .font(.body)
                                    .foregroundColor(.black)
                                Spacer()
                                if selectedGenre == genre {
                                    Image(systemName: "checkmark")
                                        .font(.body)
                                        .foregroundColor(.black)
                                }
                            }
                            .padding(.horizontal, 24)
                            .padding(.vertical, 14)
                        }

                        Divider()
                    }
                }
            }
        }
        .background(Color.white)
        .presentationDetents([.medium, .large])
    }
}

struct ListingDetailView: View {
    @Bindable var viewModel: AuthViewModel
    let listing: BookListing
    @Environment(\.dismiss) private var dismiss
    @State private var showDetails = false
    @State private var showCondition = false
    @State private var showSnoozeAlert = false
    @State private var showDeleteAlert = false

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

                    // Snooze / Delete buttons
                    HStack(spacing: 12) {
                        Button {
                            showSnoozeAlert = true
                        } label: {
                            HStack(spacing: 6) {
                                Image(systemName: "moon.zzz")
                                    .font(.subheadline)
                                Text("Snooze 48h")
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                            }
                            .foregroundColor(.orange)
                            .frame(maxWidth: .infinity)
                            .frame(height: 44)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.orange.opacity(0.5), lineWidth: 1.5)
                            )
                        }

                        Button {
                            showDeleteAlert = true
                        } label: {
                            HStack(spacing: 6) {
                                Image(systemName: "trash")
                                    .font(.subheadline)
                                Text("Delete")
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                            }
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity)
                            .frame(height: 44)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.red.opacity(0.5), lineWidth: 1.5)
                            )
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 20)
                    .padding(.bottom, 20)

                    Divider()

                    // Details accordion
                    VStack(spacing: 0) {
                        Button {
                            withAnimation { showDetails.toggle() }
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
                            withAnimation { showCondition.toggle() }
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
        .alert("Snooze Listing", isPresented: $showSnoozeAlert) {
            Button("Cancel", role: .cancel) {}
            Button("Snooze") {
                viewModel.snoozeListing(listing)
                dismiss()
            }
        } message: {
            Text("Are you sure you want to snooze this listing? Snoozing a listing will deactivate the listing for 48 hours.")
        }
        .alert("Delete Listing", isPresented: $showDeleteAlert) {
            Button("Cancel", role: .cancel) {}
            Button("Delete", role: .destructive) {
                viewModel.deleteListing(listing)
                dismiss()
            }
        } message: {
            Text("Are you sure you want to delete this listing?")
        }
    }
}
