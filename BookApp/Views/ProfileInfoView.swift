import SwiftUI

struct ProfileInfoView: View {
    @Bindable var viewModel: AuthViewModel
    @Environment(\.dismiss) private var dismiss

    // Snapshot of original values to detect changes
    @State private var originalFullName = ""
    @State private var originalStoreName = ""
    @State private var originalEmail = ""
    @State private var originalPhone = ""
    @State private var originalAddress = ""
    @State private var originalAddress2 = ""
    @State private var originalCity = ""
    @State private var originalState = ""
    @State private var originalZipCode = ""
    @State private var originalCountry = ""

    var hasChanges: Bool {
        viewModel.storeFullName != originalFullName
            || viewModel.storeName != originalStoreName
            || viewModel.storePrimaryEmail != originalEmail
            || viewModel.storeMobilePhone != originalPhone
            || viewModel.storeAddress != originalAddress
            || viewModel.storeAddress2 != originalAddress2
            || viewModel.storeCity != originalCity
            || viewModel.storeState != originalState
            || viewModel.storeZipCode != originalZipCode
            || viewModel.storeCountry != originalCountry
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

                Text("Profile")
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundColor(.black)
                    .padding(.leading, 8)

                Spacer()

                Button {
                    dismiss()
                } label: {
                    Text("Save")
                        .font(.body)
                        .foregroundColor(hasChanges ? .blue : .gray)
                }
                .disabled(!hasChanges)
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
        .onAppear {
            originalFullName = viewModel.storeFullName
            originalStoreName = viewModel.storeName
            originalEmail = viewModel.storePrimaryEmail
            originalPhone = viewModel.storeMobilePhone
            originalAddress = viewModel.storeAddress
            originalAddress2 = viewModel.storeAddress2
            originalCity = viewModel.storeCity
            originalState = viewModel.storeState
            originalZipCode = viewModel.storeZipCode
            originalCountry = viewModel.storeCountry
        }
    }
}
