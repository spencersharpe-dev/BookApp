import SwiftUI

@Observable
class AuthViewModel {
    // MARK: - Login Fields
    var loginEmail = ""
    var loginPassword = ""

    // MARK: - Create Account Fields
    var registerName = ""
    var registerEmail = ""
    var registerPassword = ""
    var agreedToTerms = true

    // MARK: - Forgot Password Fields
    var forgotPasswordEmail = ""

    // MARK: - Setup Store Fields
    var storeName = ""
    var storeFullName = ""
    var storePrimaryEmail = ""
    var storeMobilePhone = ""
    var storeAddress = ""
    var storeAddress2 = ""
    var storeCity = ""
    var storeState = ""
    var storeZipCode = ""
    var storeCountry = "United States"

    // MARK: - Book Details Fields
    var bookAuthor = ""
    var bookTitle = ""
    var bookISBN = ""
    var bookPublisher = ""
    var bookDatePublished = ""
    var bookGenre = ""
    var bookAttributes = ""
    var bookCondition = ""
    var bookSignature = ""
    var bookBindingType = ""

    // MARK: - Pricing
    var bookPrice = ""

    // MARK: - Captured Photos (during sell flow)
    var capturedPhotos: [String: UIImage] = [:]

    // MARK: - Banking & Balance
    var linkedBanks: [LinkedBank] = []
    var totalBalance: Double = 380.98
    var selectedBankId: String?

    // MARK: - Return Address (defaults to store address)
    var returnAddress = ""
    var returnAddress2 = ""
    var returnCity = ""
    var returnState = ""
    var returnZipCode = ""
    var returnCountry = "United States"

    // MARK: - Notification Settings
    var generalUpdates = false
    var newPurchases = false
    var shippingUpdates = false

    // MARK: - Listings
    var activeListings: [BookListing] = []

    // MARK: - Earnings Transactions
    var earningsTransactions: [EarningsTransaction] = [
        EarningsTransaction(description: "Sold: The Great Gatsby", amount: 24.99, type: .sale, date: Date().addingTimeInterval(-2 * 86400)),
        EarningsTransaction(description: "Sold: To Kill a Mockingbird", amount: 18.50, type: .sale, date: Date().addingTimeInterval(-5 * 86400)),
        EarningsTransaction(description: "Transfer to Chase Bank", amount: -50.00, type: .cashout, date: Date().addingTimeInterval(-7 * 86400)),
        EarningsTransaction(description: "Sold: 1984 by George Orwell", amount: 12.00, type: .sale, date: Date().addingTimeInterval(-10 * 86400)),
        EarningsTransaction(description: "Refund: Damaged in shipping", amount: -15.75, type: .refund, date: Date().addingTimeInterval(-12 * 86400)),
        EarningsTransaction(description: "Sold: Pride and Prejudice", amount: 9.99, type: .sale, date: Date().addingTimeInterval(-15 * 86400)),
        EarningsTransaction(description: "Transfer to Bank of America", amount: -100.00, type: .cashout, date: Date().addingTimeInterval(-18 * 86400)),
        EarningsTransaction(description: "Credit: Return accepted", amount: 15.75, type: .credit, date: Date().addingTimeInterval(-20 * 86400)),
        EarningsTransaction(description: "Sold: Moby Dick", amount: 22.50, type: .sale, date: Date().addingTimeInterval(-22 * 86400))
    ]

    var totalEarnings: Double {
        earningsTransactions.filter { $0.amount > 0 }.reduce(0) { $0 + $1.amount }
    }

    // MARK: - Support
    var supportRequests: [SupportRequest] = [
        SupportRequest(question: "I haven't received my payment for order #004521. It's been over 7 days since the book was delivered.", status: .active, dateCreated: Date().addingTimeInterval(-86400)),
        SupportRequest(question: "The buyer is claiming the book condition was misrepresented. I listed it as 'Good' but they say pages are torn.", status: .inProgress, dateCreated: Date().addingTimeInterval(-3 * 86400)),
        SupportRequest(question: "How do I update my bank account information for transfers?", status: .resolved, dateCreated: Date().addingTimeInterval(-7 * 86400))
    ]

    // MARK: - Navigation State
    var showForgotPassword = false
    var isAuthenticated = false
    var onboardingComplete = false
    var showPlaidIntro = false
    var dismissSellFlow = false

    // MARK: - Validation
    var loginEmailError: String? {
        guard !loginEmail.isEmpty else { return nil }
        return isValidEmail(loginEmail) ? nil : "Invalid email format"
    }

    var registerEmailError: String? {
        guard !registerEmail.isEmpty else { return nil }
        return isValidEmail(registerEmail) ? nil : "Invalid email format"
    }

    var canLogin: Bool {
        !loginEmail.isEmpty && !loginPassword.isEmpty && isValidEmail(loginEmail)
    }

    var canRegister: Bool {
        !registerName.isEmpty && !registerEmail.isEmpty && !registerPassword.isEmpty
            && isValidEmail(registerEmail) && agreedToTerms
    }

    var canResetPassword: Bool {
        !forgotPasswordEmail.isEmpty && isValidEmail(forgotPasswordEmail)
    }

    var canProceedToPhotos: Bool {
        !bookAuthor.isEmpty && !bookTitle.isEmpty && !bookISBN.isEmpty
            && !bookPublisher.isEmpty && !bookDatePublished.isEmpty
            && !bookGenre.isEmpty && !bookCondition.isEmpty
            && !bookBindingType.isEmpty
    }

    var canProceedFromSetup: Bool {
        !storeFullName.isEmpty && !storeName.isEmpty && !storePrimaryEmail.isEmpty
            && isValidEmail(storePrimaryEmail) && !storeMobilePhone.isEmpty
            && !storeAddress.isEmpty && !storeCity.isEmpty
            && !storeState.isEmpty && !storeZipCode.isEmpty && !storeCountry.isEmpty
    }

    // MARK: - Actions (placeholder for future backend integration)
    func login() {
        // TODO: Wire up authentication backend
        print("Login with: \(loginEmail)")
    }

    func createAccount() {
        // TODO: Wire up authentication backend
        print("Create account for: \(registerName), \(registerEmail)")
        isAuthenticated = true
    }

    func resetPassword() {
        // TODO: Wire up password reset
        print("Reset password for: \(forgotPasswordEmail)")
        showForgotPassword = false
    }

    func initializeReturnAddress() {
        if returnAddress.isEmpty {
            returnAddress = storeAddress
            returnAddress2 = storeAddress2
            returnCity = storeCity
            returnState = storeState
            returnZipCode = storeZipCode
            returnCountry = storeCountry
        }
    }

    func submitListing() {
        let cents = Int(bookPrice) ?? 0
        let price = Double(cents) / 100.0
        var listing = BookListing(
            title: bookTitle,
            author: bookAuthor,
            isbn: bookISBN,
            publisher: bookPublisher,
            price: price,
            datePublished: bookDatePublished,
            genre: bookGenre,
            attributes: bookAttributes,
            condition: bookCondition,
            signature: bookSignature,
            bindingType: bookBindingType,
            photos: capturedPhotos
        )
        listing.dateSold = Date()
        activeListings.append(listing)
        totalBalance += price
        earningsTransactions.insert(
            EarningsTransaction(description: "Sold: \(bookTitle)", amount: price, type: .sale, date: Date()),
            at: 0
        )
        resetBookFields()
    }

    func snoozeListing(_ listing: BookListing) {
        if let index = activeListings.firstIndex(where: { $0.id == listing.id }) {
            activeListings[index].isSnoozed = true
            activeListings[index].snoozeUntil = Date().addingTimeInterval(48 * 60 * 60)
        }
    }

    func deleteListing(_ listing: BookListing) {
        activeListings.removeAll { $0.id == listing.id }
    }

    private func resetBookFields() {
        bookAuthor = ""
        bookTitle = ""
        bookISBN = ""
        bookPublisher = ""
        bookDatePublished = ""
        bookGenre = ""
        bookAttributes = ""
        bookCondition = ""
        bookSignature = ""
        bookBindingType = ""
        bookPrice = ""
        capturedPhotos = [:]
    }

    func submitSupportRequest(_ question: String) {
        let request = SupportRequest(question: question, status: .active, dateCreated: Date())
        supportRequests.insert(request, at: 0)
    }

    func addLinkedBank(name: String, icon: String) {
        let bank = LinkedBank(name: name, icon: icon)
        if !linkedBanks.contains(where: { $0.name == name }) {
            linkedBanks.append(bank)
        }
    }

    // MARK: - Private
    private func isValidEmail(_ email: String) -> Bool {
        let pattern = #"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return email.range(of: pattern, options: .regularExpression) != nil
    }
}

struct LinkedBank: Identifiable, Equatable {
    let id = UUID().uuidString
    let name: String
    let icon: String
}

struct BookListing: Identifiable {
    let id = UUID().uuidString
    let title: String
    let author: String
    let isbn: String
    let publisher: String
    let price: Double
    let datePublished: String
    let genre: String
    let attributes: String
    let condition: String
    let signature: String
    let bindingType: String
    let photos: [String: UIImage]
    let dateCreated = Date()
    let orderNumber: String = String(format: "#%06d", Int.random(in: 1000...999999))
    var isSnoozed = false
    var snoozeUntil: Date?
    var dateSold: Date?

    var coverImage: UIImage? {
        photos["Cover"]
    }

    var formattedPrice: String {
        String(format: "$%.2f", price)
    }

    var formattedDateSold: String {
        guard let date = dateSold else { return "Pending" }
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

enum EarningsTransactionType: String {
    case sale = "Sale"
    case cashout = "Cash Out"
    case refund = "Refund"
    case credit = "Credit"
}

struct EarningsTransaction: Identifiable {
    let id = UUID().uuidString
    let description: String
    let amount: Double
    let type: EarningsTransactionType
    let date: Date

    var isPositive: Bool {
        amount > 0
    }

    var formattedAmount: String {
        if isPositive {
            return String(format: "+$%.2f", amount)
        } else {
            return String(format: "-$%.2f", abs(amount))
        }
    }

    var amountColor: Color {
        isPositive ? .green : .red
    }

    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

enum SupportStatus: String {
    case active = "Active"
    case inProgress = "In Progress"
    case resolved = "Resolved"
}

struct SupportRequest: Identifiable {
    let id = UUID().uuidString
    let question: String
    let status: SupportStatus
    let dateCreated: Date

    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: dateCreated)
    }

    var statusColor: Color {
        switch status {
        case .active: return .blue
        case .inProgress: return .orange
        case .resolved: return .green
        }
    }
}
