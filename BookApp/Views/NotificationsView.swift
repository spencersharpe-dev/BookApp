import SwiftUI

struct NotificationsView: View {
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

                Text("Notifications")
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

            // Notification toggles
            VStack(spacing: 0) {
                NotificationToggleRow(title: "General Updates", isOn: $viewModel.generalUpdates)
                NotificationToggleRow(title: "New Purchases", isOn: $viewModel.newPurchases)
                NotificationToggleRow(title: "Shipping Updates", isOn: $viewModel.shippingUpdates)
            }

            Spacer()
        }
        .background(Color.white)
    }
}

struct NotificationToggleRow: View {
    let title: String
    @Binding var isOn: Bool

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(title)
                    .font(.body)
                    .foregroundColor(.black)
                Spacer()
                Toggle("", isOn: $isOn)
                    .labelsHidden()
                    .tint(.black)
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 14)

            Divider()
        }
    }
}
