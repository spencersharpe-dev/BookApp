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
            price: price
        )
        listing.dateSold = Date()
        activeListings.append(listing)
        totalBalance += price
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
    let dateCreated = Date()
    let orderNumber: String = String(format: "#%06d", Int.random(in: 1000...999999))
    var isSnoozed = false
    var snoozeUntil: Date?
    var dateSold: Date?

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
