import SwiftUI

struct ProfileInfoView: View {
    @Bindable var viewModel: AuthViewModel
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

                Text("Profile")
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundColor(.black)
                    .padding(.leading, 8)

                Spacer()

                Button {
                    // TODO: Save profile changes
                    dismiss()
                } label: {
                    Text("Save")
                        .font(.body)
                        .foregroundColor(.blue)
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 16)
            .padding(.bottom, 12)

            Divider()

            // Profile fields
            ScrollView {
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
        .background(Color.white)
    }
}
