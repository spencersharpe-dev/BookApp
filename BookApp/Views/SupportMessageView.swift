import SwiftUI

struct SupportMessageView: View {
    @Bindable var viewModel: AuthViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var messageText = ""
    @FocusState private var isTextFieldFocused: Bool

    private let characterLimit = 200

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

                Text("Support")
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
                VStack(alignment: .leading, spacing: 12) {
                    // Text area
                    TextEditor(text: $messageText)
                        .font(.body)
                        .foregroundColor(.black)
                        .frame(minHeight: 180)
                        .padding(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                        .overlay(alignment: .topLeading) {
                            if messageText.isEmpty {
                                Text("How can we help you?")
                                    .font(.body)
                                    .foregroundColor(.gray)
                                    .padding(.top, 20)
                                    .padding(.leading, 16)
                                    .allowsHitTesting(false)
                            }
                        }
                        .focused($isTextFieldFocused)
                        .onChange(of: messageText) { _, newValue in
                            if newValue.count > characterLimit {
                                messageText = String(newValue.prefix(characterLimit))
                            }
                        }
                        .toolbar {
                            ToolbarItemGroup(placement: .keyboard) {
                                Spacer()
                                Button("Done") {
                                    isTextFieldFocused = false
                                }
                            }
                        }

                    Text("Character Limit: \(characterLimit)")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal, 24)
                .padding(.top, 20)
            }

            Spacer()

            // Send Message button
            VStack(spacing: 0) {
                Button {
                    viewModel.submitSupportRequest(messageText)
                    dismiss()
                } label: {
                    Text("Send Message")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 18)
                        .background(messageText.isEmpty ? Color.gray : Color.black)
                        .cornerRadius(12)
                }
                .disabled(messageText.isEmpty)
                .padding(.horizontal, 24)
                .padding(.bottom, 32)
            }
        }
        .background(Color.white)
    }
}
