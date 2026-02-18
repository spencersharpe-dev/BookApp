import SwiftUI

struct AgreementsView: View {
    @Bindable var viewModel: AuthViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var showTerms = false
    @State private var showPrivacy = false

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

                Text("Agreements")
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundColor(.black)
                    .padding(.leading, 8)

                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.top, 16)
            .padding(.bottom, 12)

            Divider()

            // Agreement rows
            VStack(spacing: 0) {
                AgreementRow(title: "Terms & Conditions") {
                    showTerms = true
                }
                AgreementRow(title: "Privacy Policy") {
                    showPrivacy = true
                }
            }

            Spacer()
        }
        .background(Color.white)
        .fullScreenCover(isPresented: $showTerms) {
            TermsConditionsView()
        }
        .fullScreenCover(isPresented: $showPrivacy) {
            PrivacyPolicyView()
        }
    }
}

struct AgreementRow: View {
    let title: String
    let action: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            Button(action: action) {
                HStack {
                    Text(title)
                        .font(.body)
                        .foregroundColor(.black)
                    Spacer()
                    Text("View")
                        .font(.body)
                        .foregroundColor(.blue)
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 18)
            }

            Divider()
        }
    }
}

struct TermsConditionsView: View {
    @Environment(\.dismiss) private var dismiss

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

                Text("Terms & Conditions")
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundColor(.black)
                    .padding(.leading, 8)

                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.top, 16)
            .padding(.bottom, 12)

            Divider()

            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Terms & Conditions")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.black)

                    Text("Last Updated: February 1, 2026")
                        .font(.caption)
                        .foregroundColor(.gray)

                    Text("1. Acceptance of Terms")
                        .font(.headline)
                        .foregroundColor(.black)

                    Text("By accessing and using BookApp, you agree to be bound by these Terms and Conditions. If you do not agree with any part of these terms, you may not use our services.")
                        .font(.body)
                        .foregroundColor(.black)

                    Text("2. Account Registration")
                        .font(.headline)
                        .foregroundColor(.black)

                    Text("You must provide accurate and complete information when creating an account. You are responsible for maintaining the confidentiality of your account credentials and for all activities that occur under your account.")
                        .font(.body)
                        .foregroundColor(.black)

                    Text("3. Selling Books")
                        .font(.headline)
                        .foregroundColor(.black)

                    Text("Sellers are responsible for accurately describing the condition of their books. Misrepresentation of book condition may result in account suspension. All listed prices are in USD and are subject to applicable fees.")
                        .font(.body)
                        .foregroundColor(.black)

                    Text("4. Payments & Transfers")
                        .font(.headline)
                        .foregroundColor(.black)

                    Text("Payments for sold books will be credited to your BookApp balance. You may transfer funds to a linked bank account at any time. Transfers typically process within 3-5 business days. BookApp reserves the right to hold funds pending verification.")
                        .font(.body)
                        .foregroundColor(.black)

                    Text("5. Returns & Refunds")
                        .font(.headline)
                        .foregroundColor(.black)

                    Text("Buyers may request a return within 14 days of delivery if the book does not match the listed description. Refunds will be issued to the original payment method. Sellers may be charged a return shipping fee if the return is due to misrepresentation.")
                        .font(.body)
                        .foregroundColor(.black)

                    Text("6. Prohibited Activities")
                        .font(.headline)
                        .foregroundColor(.black)

                    Text("Users may not list counterfeit, stolen, or prohibited materials. Any attempt to manipulate pricing, reviews, or transaction records will result in immediate account termination.")
                        .font(.body)
                        .foregroundColor(.black)

                    Text("7. Limitation of Liability")
                        .font(.headline)
                        .foregroundColor(.black)

                    Text("BookApp is not responsible for any damages arising from the use of our platform, including but not limited to lost profits, data loss, or business interruption. Our total liability shall not exceed the amount of fees paid by you in the preceding 12 months.")
                        .font(.body)
                        .foregroundColor(.black)

                    Text("8. Changes to Terms")
                        .font(.headline)
                        .foregroundColor(.black)

                    Text("BookApp reserves the right to modify these terms at any time. Continued use of the platform after changes constitutes acceptance of the revised terms. We will notify users of significant changes via email or in-app notification.")
                        .font(.body)
                        .foregroundColor(.black)
                }
                .padding(.horizontal, 24)
                .padding(.top, 16)
                .padding(.bottom, 32)
            }
        }
        .background(Color.white)
    }
}

struct PrivacyPolicyView: View {
    @Environment(\.dismiss) private var dismiss

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

                Text("Privacy Policy")
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundColor(.black)
                    .padding(.leading, 8)

                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.top, 16)
            .padding(.bottom, 12)

            Divider()

            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Privacy Policy")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.black)

                    Text("Last Updated: February 1, 2026")
                        .font(.caption)
                        .foregroundColor(.gray)

                    Text("1. Information We Collect")
                        .font(.headline)
                        .foregroundColor(.black)

                    Text("We collect information you provide directly, including your name, email address, phone number, mailing address, and banking information. We also collect usage data such as browsing activity, transaction history, and device information.")
                        .font(.body)
                        .foregroundColor(.black)

                    Text("2. How We Use Your Information")
                        .font(.headline)
                        .foregroundColor(.black)

                    Text("Your information is used to facilitate transactions, process payments, provide customer support, and improve our services. We may also use your information to send you important updates about your account and our platform.")
                        .font(.body)
                        .foregroundColor(.black)

                    Text("3. Data Sharing")
                        .font(.headline)
                        .foregroundColor(.black)

                    Text("We do not sell your personal information. We may share data with third-party service providers (such as payment processors and shipping partners) as necessary to operate our platform. We may also disclose information when required by law.")
                        .font(.body)
                        .foregroundColor(.black)

                    Text("4. Contact Us")
                        .font(.headline)
                        .foregroundColor(.black)

                    Text("If you have questions about this Privacy Policy, please contact us through the Support section of the app.")
                        .font(.body)
                        .foregroundColor(.black)
                }
                .padding(.horizontal, 24)
                .padding(.top, 16)
                .padding(.bottom, 32)
            }
        }
        .background(Color.white)
    }
}
