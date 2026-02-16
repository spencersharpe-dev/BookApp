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

    // MARK: - Navigation State
    var showForgotPassword = false
    var isAuthenticated = false
    var showPlaidIntro = false

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

    // MARK: - Private
    private func isValidEmail(_ email: String) -> Bool {
        let pattern = #"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return email.range(of: pattern, options: .regularExpression) != nil
    }
}
