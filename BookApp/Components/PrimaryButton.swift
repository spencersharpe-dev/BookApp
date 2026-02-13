import SwiftUI

struct PrimaryButton: View {
    let title: String
    var style: ButtonStyle = .light
    var action: () -> Void

    enum ButtonStyle {
        case light
        case dark
    }

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(style == .light ? .black : .white)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(style == .light ? Color.white : Color.black)
                .cornerRadius(12)
        }
    }
}
