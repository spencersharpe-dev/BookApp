import SwiftUI

struct MakeOfferView: View {
    let listing: BookListing
    @Environment(\.dismiss) private var dismiss
    @State private var offerPrice = ""
    @State private var showOfferSuccess = false
    @FocusState private var isPriceFocused: Bool

    var formattedPrice: String {
        let cents = Int(offerPrice) ?? 0
        let dollars = Double(cents) / 100.0
        return String(format: "$%.2f", dollars)
    }

    var offerAmount: Double {
        let cents = Int(offerPrice) ?? 0
        return Double(cents) / 100.0
    }

    var canMakeOffer: Bool {
        offerAmount >= 10.0
    }

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

                Text("Make Offer")
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundColor(.black)
                    .padding(.leading, 8)

                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.top, 16)
            .padding(.bottom, 12)

            Spacer()

            // Price display
            VStack(spacing: 8) {
                Text(formattedPrice)
                    .font(.system(size: 48, weight: .bold))
                    .foregroundColor(.black)

                Text(listing.title)
                    .font(.body)
                    .foregroundColor(.black)

                Text(listing.author)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }

            Spacer()

            // Make Offer button
            Button {
                showOfferSuccess = true
            } label: {
                Text("Make Offer")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(canMakeOffer ? .white : .black)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(canMakeOffer ? Color.black : Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(canMakeOffer ? Color.clear : Color.gray.opacity(0.3), lineWidth: 1.5)
                    )
                    .cornerRadius(12)
            }
            .disabled(!canMakeOffer)
            .padding(.horizontal, 24)
            .padding(.bottom, 12)

            // Hidden text field for numeric input
            TextField("", text: $offerPrice)
                .keyboardType(.numberPad)
                .focused($isPriceFocused)
                .frame(width: 0, height: 0)
                .opacity(0)
        }
        .background(Color.white)
        .onAppear {
            isPriceFocused = true
        }
        .fullScreenCover(isPresented: $showOfferSuccess) {
            OfferSuccessView(listing: listing, offerAmount: formattedPrice)
        }
    }
}
