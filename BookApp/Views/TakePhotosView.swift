import SwiftUI

enum PhotoType: String, CaseIterable, Identifiable {
    case cover = "Cover"
    case insideCoverFront = "Inside Cover - Front"
    case samplePage = "Sample Page"
    case insideCoverBack = "Inside Cover - Back"
    case backCover = "Back Cover"

    var id: String { rawValue }

    var silhouetteIcon: String {
        switch self {
        case .cover:
            return "book.closed"
        case .insideCoverFront:
            return "book.pages"
        case .samplePage:
            return "doc.text"
        case .insideCoverBack:
            return "book.pages"
        case .backCover:
            return "book.closed.fill"
        }
    }

    var silhouetteDescription: String {
        switch self {
        case .cover:
            return "Position the front cover of the book"
        case .insideCoverFront:
            return "Position the inside front cover"
        case .samplePage:
            return "Position a sample page"
        case .insideCoverBack:
            return "Position the inside back cover"
        case .backCover:
            return "Position the back cover of the book"
        }
    }
}

struct TakePhotosView: View {
    @Bindable var viewModel: AuthViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var selectedPhotoType: PhotoType?
    @State private var capturedPhotos: [PhotoType: UIImage] = [:]
    @State private var showAddPrice = false

    var body: some View {
        VStack(spacing: 0) {
            // Header
            Divider()

            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                        .foregroundColor(.black)
                }

                Text("Add photos")
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundColor(.black)
                    .padding(.leading, 8)

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

            // Photo type list
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(PhotoType.allCases) { photoType in
                        Button {
                            selectedPhotoType = photoType
                        } label: {
                            HStack {
                                Text(photoType.rawValue)
                                    .font(.body)
                                    .foregroundColor(.black)
                                Spacer()
                                if capturedPhotos[photoType] != nil {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.green)
                                }
                            }
                            .padding(.horizontal, 24)
                            .padding(.vertical, 14)
                        }

                        Divider()
                    }
                }
            }

            Spacer()

            // Add Price button
            HStack {
                Spacer()
                Button {
                    showAddPrice = true
                } label: {
                    HStack(spacing: 8) {
                        Text("Add Price")
                            .font(.title2)
                            .fontWeight(.medium)
                            .italic()
                        Image(systemName: "arrow.right")
                            .font(.title2)
                    }
                    .foregroundColor(.black)
                }
                .padding(.trailing, 24)
                .padding(.vertical, 20)
            }
        }
        .background(Color.white)
        .fullScreenCover(item: $selectedPhotoType) { photoType in
            BookCameraView(photoType: photoType) { image in
                capturedPhotos[photoType] = image
            }
        }
        .fullScreenCover(isPresented: $showAddPrice) {
            AddPriceView(viewModel: viewModel)
        }
        .onChange(of: viewModel.dismissSellFlow) { _, shouldDismiss in
            if shouldDismiss {
                dismiss()
            }
        }
    }
}
