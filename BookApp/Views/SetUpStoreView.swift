import SwiftUI

struct SetUpStoreView: View {
    @Bindable var viewModel: AuthViewModel
    @State private var navigateToLinkBank = false

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Set up your store")
                        .font(.title2)
                        .fontWeight(.medium)
                        .foregroundColor(.black)
                        .padding(.top, 40)
                        .padding(.horizontal, 24)

                    Divider()
                        .padding(.top, 8)

                    VStack(spacing: 0) {
                        SetUpField(label: "Full Name", text: $viewModel.storeFullName)
                        SetUpField(label: "Store Name", text: $viewModel.storeName)
                        SetUpField(label: "Primary Email", text: $viewModel.storePrimaryEmail, keyboardType: .emailAddress)
                        SetUpField(label: "Mobile Phone", text: $viewModel.storeMobilePhone, keyboardType: .phonePad)
                        SetUpField(label: "Address", text: $viewModel.storeAddress)
                        SetUpField(label: "Address 2", text: $viewModel.storeAddress2, placeholder: "Enter Address 2")
                        SetUpField(label: "City", text: $viewModel.storeCity)
                        SetUpField(label: "State", text: $viewModel.storeState)
                        SetUpField(label: "Zip Code", text: $viewModel.storeZipCode, keyboardType: .numberPad)
                        SetUpField(label: "Country", text: $viewModel.storeCountry)
                    }
                    .padding(.horizontal, 24)
                }
            }

            // Next button
            HStack {
                Spacer()
                Button {
                    navigateToLinkBank = true
                } label: {
                    HStack(spacing: 8) {
                        Text("Next")
                            .font(.title2)
                            .fontWeight(.medium)
                            .italic()
                        Image(systemName: "arrow.right")
                            .font(.title2)
                    }
                    .foregroundColor(viewModel.canProceedFromSetup ? .black : .gray)
                }
                .disabled(!viewModel.canProceedFromSetup)
                .padding(.trailing, 24)
                .padding(.vertical, 20)
            }
        }
        .background(Color.white)
        .fullScreenCover(isPresented: $navigateToLinkBank) {
            LinkBankAccountView(viewModel: viewModel)
        }
    }
}

struct SetUpField: View {
    let label: String
    @Binding var text: String
    var placeholder: String? = nil
    var keyboardType: UIKeyboardType = .default

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(label)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Spacer()
                TextField("", text: $text, prompt: Text(placeholder ?? "Enter \(label)").foregroundColor(.gray.opacity(0.4)))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(keyboardType)
                    .textInputAutocapitalization(keyboardType == .emailAddress ? .never : .words)
                    .autocorrectionDisabled()
            }
            .padding(.vertical, 14)

            Divider()
                .background(Color.gray.opacity(0.3))
        }
    }
}
