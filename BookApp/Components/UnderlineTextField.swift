import SwiftUI

struct UnderlineTextField: View {
    let placeholder: String
    @Binding var text: String
    var isSecure: Bool = false
    var trailingContent: AnyView? = nil

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                if isSecure {
                    SecureField("", text: $text, prompt: Text(placeholder).foregroundColor(.gray))
                        .foregroundColor(.white)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                } else {
                    TextField("", text: $text, prompt: Text(placeholder).foregroundColor(.gray))
                        .foregroundColor(.white)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                }

                if let trailing = trailingContent {
                    trailing
                }
            }
            .padding(.vertical, 12)

            Divider()
                .frame(height: 0.5)
                .background(Color.gray.opacity(0.5))
        }
    }
}

struct UnderlineTextFieldLight: View {
    let placeholder: String
    @Binding var text: String

    var body: some View {
        VStack(spacing: 0) {
            TextField("", text: $text, prompt: Text(placeholder).foregroundColor(.gray.opacity(0.5)))
                .foregroundColor(.black)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .padding(.vertical, 12)

            Divider()
                .frame(height: 0.5)
                .background(Color.gray.opacity(0.3))
        }
    }
}
