import SwiftUI

struct OnboardingPage {
    let icon: String
    let title: String
    let description: String
}

struct OnboardingView: View {
    @Bindable var viewModel: AuthViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var currentPage = 0

    private let pages: [OnboardingPage] = [
        OnboardingPage(
            icon: "book.and.wrench",
            title: "How it works",
            description: "Learn how to get up and running in a couple minutes"
        ),
        OnboardingPage(
            icon: "book.badge.plus",
            title: "Add book details",
            description: "Review the selling guide. We review all books sold on \"App Name\" so it's important to follow these steps to avoid suspension."
        ),
        OnboardingPage(
            icon: "iphone.rear.camera",
            title: "Add clear photos",
            description: "Sellers are required to take several clear and accurate photos. This helps the buyer clearly see the condition of the item and will help you sell more books!"
        ),
        OnboardingPage(
            icon: "dollarsign.square",
            title: "Name your price",
            description: "Sellers must ship within 2 business days in order to avoid penalties. Don't worry, we'll send you the shipping label.\n\nSeller must also ensure items are properly packed to avoid damages. Review shipping guidelines here."
        ),
        OnboardingPage(
            icon: "iphone.and.arrow.forward",
            title: "Share and Sell",
            description: "You'll be paid 48 hours after delivery. In order to receive funds, you'll need to set up your PayPal account in your seller profile."
        )
    ]

    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            // Icon
            Image(systemName: pages[currentPage].icon)
                .font(.system(size: 80))
                .foregroundColor(.black)

            // Title
            Text(pages[currentPage].title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.top, 32)

            // Description
            Text(pages[currentPage].description)
                .font(.body)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
                .padding(.top, 12)

            Spacer()

            // Bottom navigation
            HStack {
                Button {
                    if currentPage > 0 {
                        withAnimation {
                            currentPage -= 1
                        }
                    } else {
                        dismiss()
                    }
                } label: {
                    HStack(spacing: 8) {
                        Image(systemName: "arrow.left")
                            .font(.title2)
                        Text("Back")
                            .font(.title2)
                            .fontWeight(.medium)
                            .italic()
                    }
                    .foregroundColor(.black)
                }

                Spacer()

                if currentPage < pages.count - 1 {
                    Button {
                        withAnimation {
                            currentPage += 1
                        }
                    } label: {
                        HStack(spacing: 8) {
                            Text("Next")
                                .font(.title2)
                                .fontWeight(.medium)
                                .italic()
                            Image(systemName: "arrow.right")
                                .font(.title2)
                        }
                        .foregroundColor(.black)
                    }
                } else {
                    Button {
                        // TODO: Navigate to main app
                    } label: {
                        Text("Finish")
                            .font(.title2)
                            .fontWeight(.medium)
                            .italic()
                            .foregroundColor(.black)
                    }
                }
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 40)
        }
        .background(Color.white)
    }
}
