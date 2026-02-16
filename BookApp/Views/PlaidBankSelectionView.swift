import SwiftUI

struct PlaidBankSelectionView: View {
    @Bindable var viewModel: AuthViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var searchText = ""

    private let banks: [(name: String, url: String)] = [
        ("Chase", "www.chase.com"),
        ("Bank of America", "www.bankofamerica.com"),
        ("Wells Fargo", "www.wellsfargo.com"),
        ("First American", "www.firstamerican.com"),
        ("Bank of California", "www.bankofcalifornia.com"),
        ("Nevada Credit Union", "www.nevadacreditunion.com"),
        ("Orange County Credit Union", "www.occc.com")
    ]

    var filteredBanks: [(name: String, url: String)] {
        if searchText.isEmpty {
            return banks
        }
        return banks.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }

    var body: some View {
        VStack(spacing: 0) {
            Divider()

            // Header
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title2)
                        .foregroundColor(.black)
                }

                Spacer()

                Text("Plaid")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.black)

                Spacer()

                Button {
                    // Dismiss all the way back to LinkBankAccountView
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.title2)
                        .fontWeight(.medium)
                        .foregroundColor(.black)
                }
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 16)

            // Select your bank
            Text("Select your bank")
                .font(.body)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 24)
                .padding(.top, 8)

            // Search bar
            HStack(spacing: 8) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField("Search", text: $searchText)
                    .foregroundColor(.black)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
            }
            .padding(12)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
            )
            .padding(.horizontal, 24)
            .padding(.top, 12)

            // Bank list
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(filteredBanks, id: \.name) { bank in
                        Button {
                            // TODO: Handle bank selection
                        } label: {
                            HStack(spacing: 16) {
                                // Placeholder bank icon
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                    .frame(width: 48, height: 48)
                                    .overlay(
                                        Image(systemName: "photo")
                                            .foregroundColor(.gray.opacity(0.4))
                                    )

                                VStack(alignment: .leading, spacing: 2) {
                                    Text(bank.name)
                                        .font(.body)
                                        .fontWeight(.medium)
                                        .foregroundColor(.black)
                                    Text(bank.url)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }

                                Spacer()
                            }
                            .padding(.horizontal, 24)
                            .padding(.vertical, 12)
                        }

                        Divider()
                            .padding(.leading, 24)
                    }
                }
            }
            .padding(.top, 12)
        }
        .background(Color.white)
    }
}
