import SwiftUI

struct ReturnAddressView: View {
    @Bindable var viewModel: AuthViewModel
    @Environment(\.dismiss) private var dismiss

    @State private var originalAddress = ""
    @State private var originalAddress2 = ""
    @State private var originalCity = ""
    @State private var originalState = ""
    @State private var originalZipCode = ""
    @State private var originalCountry = ""

    var hasChanges: Bool {
        viewModel.returnAddress != originalAddress
            || viewModel.returnAddress2 != originalAddress2
            || viewModel.returnCity != originalCity
            || viewModel.returnState != originalState
            || viewModel.returnZipCode != originalZipCode
            || viewModel.returnCountry != originalCountry
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

                Text("Return Address")
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

            ScrollView {
                VStack(spacing: 0) {
                    SetUpField(label: "Address", text: $viewModel.returnAddress)
                    SetUpField(label: "Address 2", text: $viewModel.returnAddress2, placeholder: "Enter Address 2")
                    SetUpField(label: "City", text: $viewModel.returnCity)
                    SetUpField(label: "State", text: $viewModel.returnState)
                    SetUpField(label: "Zip Code", text: $viewModel.returnZipCode, keyboardType: .numberPad)
                    SetUpField(label: "Country", text: $viewModel.returnCountry)
                }
                .padding(.horizontal, 24)
            }
        }
        .background(Color.white)
        .onAppear {
            viewModel.initializeReturnAddress()
            originalAddress = viewModel.returnAddress
            originalAddress2 = viewModel.returnAddress2
            originalCity = viewModel.returnCity
            originalState = viewModel.returnState
            originalZipCode = viewModel.returnZipCode
            originalCountry = viewModel.returnCountry
        }
    }
}
