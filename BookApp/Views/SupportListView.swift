import SwiftUI

struct SupportListView: View {
    @Bindable var viewModel: AuthViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var showNewRequest = false

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

            if viewModel.supportRequests.isEmpty {
                Spacer()
                Text("No support requests yet")
                    .font(.body)
                    .foregroundColor(.gray)
                Spacer()
            } else {
                // Column headers
                HStack {
                    Text("Request")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Status")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .frame(width: 80, alignment: .trailing)
                    Text("Date")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .frame(width: 90, alignment: .trailing)
                }
                .padding(.horizontal, 24)
                .padding(.top, 12)
                .padding(.bottom, 8)

                Divider()

                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(viewModel.supportRequests) { request in
                            VStack(spacing: 0) {
                                HStack {
                                    Text(request.question)
                                        .font(.body)
                                        .foregroundColor(.black)
                                        .lineLimit(2)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    Text(request.status.rawValue)
                                        .font(.caption)
                                        .fontWeight(.medium)
                                        .foregroundColor(request.statusColor)
                                        .frame(width: 80, alignment: .trailing)
                                    Text(request.formattedDate)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                        .frame(width: 90, alignment: .trailing)
                                }
                                .padding(.horizontal, 24)
                                .padding(.vertical, 14)

                                Divider()
                            }
                        }
                    }
                }
            }

            // Fixed Request Support button at bottom
            VStack(spacing: 0) {
                Divider()
                Button {
                    showNewRequest = true
                } label: {
                    Text("Request Support")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 18)
                        .background(Color.black)
                        .cornerRadius(12)
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 16)
            }
        }
        .background(Color.white)
        .fullScreenCover(isPresented: $showNewRequest) {
            SupportMessageView(viewModel: viewModel)
        }
    }
}
