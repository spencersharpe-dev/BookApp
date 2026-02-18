import SwiftUI

struct CheckoutView: View {
    let listing: BookListing
    let sellerName: String
    @Environment(\.dismiss) private var dismiss
    @State private var showOrderConfirmation = false

    var shippingEstimate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        let date = Date().addingTimeInterval(7 * 86400)
        return formatter.string(from: date)
    }

    var tax: Double {
        listing.price * 0.08
    }

    var shippingCost: Double {
        4.99
    }

    var total: Double {
        listing.price + tax + shippingCost
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

                Text("Checkout")
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundColor(.black)
                    .padding(.leading, 8)

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
            .padding(.bottom, 12)

            Divider()

            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    // Order summary
                    Text("Order Summary")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.horizontal, 24)
                        .padding(.top, 20)

                    // Book info
                    HStack(spacing: 16) {
                        if let coverImage = listing.coverImage {
                            Image(uiImage: coverImage)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 60, height: 80)
                                .cornerRadius(4)
                        } else {
                            Image(systemName: "book.closed")
                                .font(.system(size: 30))
                                .foregroundColor(.gray.opacity(0.4))
                                .frame(width: 60, height: 80)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
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

                            Text("Sold by: \(sellerName)")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }

                        Spacer()

                        Text(listing.formattedPrice)
                            .font(.body)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 16)
                    .padding(.bottom, 20)

                    Divider()

                    // Shipping
                    Text("Shipping")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.horizontal, 24)
                        .padding(.top, 20)

                    VStack(spacing: 8) {
                        HStack {
                            Text("Standard Shipping")
                                .font(.body)
                                .foregroundColor(.black)
                            Spacer()
                            Text(String(format: "$%.2f", shippingCost))
                                .font(.body)
                                .foregroundColor(.black)
                        }
                        HStack {
                            Text("Estimated delivery")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Spacer()
                            Text(shippingEstimate)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 12)
                    .padding(.bottom, 20)

                    Divider()

                    // Payment
                    Text("Payment")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.horizontal, 24)
                        .padding(.top, 20)

                    HStack {
                        Image(systemName: "creditcard.fill")
                            .foregroundColor(.black)
                        Text("Add Payment Method")
                            .font(.body)
                            .foregroundColor(.blue)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 12)
                    .padding(.bottom, 20)

                    Divider()

                    // Price breakdown
                    VStack(spacing: 12) {
                        HStack {
                            Text("Subtotal")
                                .font(.body)
                                .foregroundColor(.black)
                            Spacer()
                            Text(listing.formattedPrice)
                                .font(.body)
                                .foregroundColor(.black)
                        }
                        HStack {
                            Text("Shipping")
                                .font(.body)
                                .foregroundColor(.black)
                            Spacer()
                            Text(String(format: "$%.2f", shippingCost))
                                .font(.body)
                                .foregroundColor(.black)
                        }
                        HStack {
                            Text("Tax")
                                .font(.body)
                                .foregroundColor(.black)
                            Spacer()
                            Text(String(format: "$%.2f", tax))
                                .font(.body)
                                .foregroundColor(.black)
                        }

                        Divider()

                        HStack {
                            Text("Total")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                            Spacer()
                            Text(String(format: "$%.2f", total))
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 20)
                    .padding(.bottom, 24)
                }
            }

            // Place Order button
            VStack(spacing: 0) {
                Divider()
                Button {
                    showOrderConfirmation = true
                } label: {
                    Text("Place Order")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(Color.black)
                        .cornerRadius(12)
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 16)
            }
        }
        .background(Color.white)
        .alert("Order Placed!", isPresented: $showOrderConfirmation) {
            Button("OK") {
                dismiss()
            }
        } message: {
            Text("Your order for \"\(listing.title)\" has been placed successfully. You will receive a confirmation email shortly.")
        }
    }
}
