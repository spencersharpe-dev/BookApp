import SwiftUI

struct OfferSuccessView: View {
    let listing: BookListing
    let offerAmount: String
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 0) {
            // Header with X
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(.black)
                }
                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.top, 16)

            Spacer()

            // Success content
            VStack(spacing: 16) {
                Image(systemName: "checkmark.circle")
                    .font(.system(size: 70, weight: .thin))
                    .foregroundColor(.black)

                Text("Offer Sent!")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)

                Text(listing.title)
                    .font(.body)
                    .foregroundColor(.black)

                Text(listing.author)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }

            Spacer()

            // Done button
            Button {
                dismiss()
            } label: {
                Text("Done")
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
        }
        .background(Color.white)
    }
}
