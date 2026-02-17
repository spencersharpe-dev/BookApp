import SwiftUI

struct BookDetailsView: View {
    @Bindable var viewModel: AuthViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var showTakePhotos = false

    var body: some View {
        VStack(spacing: 0) {
            // Header
            Divider()

            HStack {
                Text("Add book details")
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundColor(.black)
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(.black)
                }
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 16)

            Divider()

            // Form fields
            ScrollView {
                VStack(spacing: 0) {
                    BookDetailField(label: "Author", placeholder: "Add Author", text: $viewModel.bookAuthor)
                    BookDetailField(label: "Title", placeholder: "Add Title", text: $viewModel.bookTitle)
                    BookDetailField(label: "ISBN", placeholder: "Add ISBN", text: $viewModel.bookISBN, keyboardType: .numberPad)
                    BookDetailField(label: "Publisher", placeholder: "Add Publisher", text: $viewModel.bookPublisher)
                    BookDetailField(label: "Date Published", placeholder: "Add Publishing Date", text: $viewModel.bookDatePublished)
                    BookDetailField(label: "Genre", placeholder: "Add Genre", text: $viewModel.bookGenre)
                    BookDetailField(label: "Attributes", placeholder: "Select Attributes", text: $viewModel.bookAttributes)
                    BookDetailField(label: "Condition", placeholder: "Select Condition", text: $viewModel.bookCondition)
                    BookDetailField(label: "Signature", placeholder: "Select Signature", text: $viewModel.bookSignature)
                    BookDetailField(label: "Binding Type", placeholder: "Select Binding Type", text: $viewModel.bookBindingType)
                }
                .padding(.horizontal, 24)
            }

            // Take Photos button
            HStack {
                Spacer()
                Button {
                    showTakePhotos = true
                } label: {
                    HStack(spacing: 8) {
                        Text("Take Photos")
                            .font(.title2)
                            .fontWeight(.medium)
                            .italic()
                        Image(systemName: "arrow.right")
                            .font(.title2)
                    }
                    .foregroundColor(viewModel.canProceedToPhotos ? .black : .gray)
                }
                .disabled(!viewModel.canProceedToPhotos)
                .padding(.trailing, 24)
                .padding(.vertical, 20)
            }
        }
        .background(Color.white)
        .fullScreenCover(isPresented: $showTakePhotos) {
            TakePhotosView(viewModel: viewModel)
        }
    }
}

struct BookDetailField: View {
    let label: String
    let placeholder: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(label)
                    .font(.body)
                    .foregroundColor(.black)
                Spacer()
                TextField("", text: $text, prompt: Text(placeholder).foregroundColor(.gray.opacity(0.5)))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(keyboardType)
                    .textInputAutocapitalization(.words)
                    .autocorrectionDisabled()
            }
            .padding(.vertical, 14)

            Divider()
                .background(Color.gray.opacity(0.3))
        }
    }
}
