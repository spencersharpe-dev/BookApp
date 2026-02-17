import SwiftUI

struct AddPriceView: View {
    @Bindable var viewModel: AuthViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var showReviewListing = false
    @FocusState private var isPriceFocused: Bool

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

                Text("Add price")
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

            // Price display
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

            // Set Price button
            Button {
                showReviewListing = true
            } label: {
                Text("Set Price")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(Color.black)
                    .cornerRadius(12)
            }
            .disabled(viewModel.bookPrice.isEmpty || viewModel.bookPrice == "0")
            .opacity(viewModel.bookPrice.isEmpty || viewModel.bookPrice == "0" ? 0.5 : 1)
            .padding(.horizontal, 24)
            .padding(.bottom, 12)

            // Hidden text field for numeric input
            TextField("", text: $viewModel.bookPrice)
                .keyboardType(.numberPad)
                .focused($isPriceFocused)
                .frame(width: 0, height: 0)
                .opacity(0)
        }
        .background(Color.white)
        .onAppear {
            isPriceFocused = true
        }
        .fullScreenCover(isPresented: $showReviewListing) {
            ReviewListingView(viewModel: viewModel)
        }
        .onChange(of: viewModel.dismissSellFlow) { _, shouldDismiss in
            if shouldDismiss {
                dismiss()
            }
        }
    }
}
