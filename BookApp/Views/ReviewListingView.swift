import SwiftUI

struct ReviewListingView: View {
    @Bindable var viewModel: AuthViewModel
    @Environment(\.dismiss) private var dismiss

    var formattedPrice: String {
        let cents = Int(viewModel.bookPrice) ?? 0
        let dollars = Double(cents) / 100.0
        return String(format: "$%.2f", dollars)
    }

    var body: some View {
        VStack(spacing: 0) {
            // Header
            Divider()

            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                        .foregroundColor(.black)
                }

                Text("Add to book store")
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundColor(.black)
                    .padding(.leading, 8)

                Spacer()

                Button {
                    viewModel.dismissSellFlow = true
                } label: {
                    Image(systemName: "xmark")
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(.black)
                }
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 16)

            Spacer()

            // Price and book info
            VStack(spacing: 8) {
                Text(formattedPrice)
                    .font(.system(size: 48, weight: .bold))
                    .foregroundColor(.black)

                Text(viewModel.bookTitle.isEmpty ? "Book Title" : viewModel.bookTitle)
                    .font(.body)
                    .foregroundColor(.black)

                Text(viewModel.bookAuthor.isEmpty ? "Author" : viewModel.bookAuthor)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }

            Spacer()

            // Done button
            Button {
                viewModel.submitListing()
                viewModel.dismissSellFlow = true
            } label: {
                Text("Done")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.black, lineWidth: 2)
                    )
                    .cornerRadius(12)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 40)
        }
        .background(Color.white)
    }
}
