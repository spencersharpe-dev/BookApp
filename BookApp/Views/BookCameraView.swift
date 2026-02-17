import SwiftUI
import AVFoundation

struct BookCameraView: View {
    let photoType: PhotoType
    let onCapture: (UIImage) -> Void

    @Environment(\.dismiss) private var dismiss
    @StateObject private var camera = CameraModel()

    var body: some View {
        ZStack {
            // Camera preview
            CameraPreview(camera: camera)
                .ignoresSafeArea()

            // Silhouette overlay
            SilhouetteOverlay(photoType: photoType)

            // Controls
            VStack {
                // Top bar
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.title2)
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                            .padding(12)
                            .background(Color.black.opacity(0.5))
                            .clipShape(Circle())
                    }

                    Spacer()

                    Text(photoType.rawValue)
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.black.opacity(0.5))
                        .cornerRadius(20)

                    Spacer()

                    // Invisible spacer to center the title
                    Color.clear
                        .frame(width: 44, height: 44)
                }
                .padding(.horizontal, 24)
                .padding(.top, 16)

                Spacer()

                // Instruction text
                Text(photoType.silhouetteDescription)
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(8)
                    .padding(.bottom, 20)

                // Capture button
                Button {
                    camera.capturePhoto { image in
                        if let image {
                            onCapture(image)
                            dismiss()
                        }
                    }
                } label: {
                    ZStack {
                        Circle()
                            .stroke(Color.white, lineWidth: 4)
                            .frame(width: 72, height: 72)
                        Circle()
                            .fill(Color.white)
                            .frame(width: 60, height: 60)
                    }
                }
                .padding(.bottom, 40)
            }
        }
        .background(Color.black)
        .onAppear {
            camera.checkPermissions()
        }
    }
}

// MARK: - Silhouette Overlay

struct SilhouetteOverlay: View {
    let photoType: PhotoType

    var body: some View {
        GeometryReader { geometry in
            let bookWidth = geometry.size.width * 0.65
            let bookHeight = geometry.size.height * 0.55

            ZStack {
                // Semi-transparent background
                Color.black.opacity(0.4)

                // Cutout area with silhouette
                VStack(spacing: 12) {
                    silhouetteShape(width: bookWidth, height: bookHeight)
                }
                .position(x: geometry.size.width / 2, y: geometry.size.height * 0.42)
            }
        }
        .ignoresSafeArea()
        .allowsHitTesting(false)
    }

    @ViewBuilder
    private func silhouetteShape(width: CGFloat, height: CGFloat) -> some View {
        switch photoType {
        case .cover:
            // Book front cover silhouette
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.white.opacity(0.6), lineWidth: 2)
                    .frame(width: width, height: height)

                VStack(spacing: 12) {
                    Image(systemName: "book.closed")
                        .font(.system(size: 48))
                        .foregroundColor(.white.opacity(0.3))
                    Text("Front Cover")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.4))
                }
            }

        case .insideCoverFront:
            // Open book showing inside front cover
            ZStack {
                // Left page (inside cover)
                HStack(spacing: 2) {
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.white.opacity(0.6), lineWidth: 2)
                        .frame(width: width * 0.48, height: height)

                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.white.opacity(0.3), lineWidth: 1)
                        .frame(width: width * 0.48, height: height)
                }

                VStack(spacing: 12) {
                    Image(systemName: "book.pages")
                        .font(.system(size: 48))
                        .foregroundColor(.white.opacity(0.3))
                    Text("Inside Front Cover")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.4))
                }
            }

        case .samplePage:
            // Single page with text lines
            ZStack {
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color.white.opacity(0.6), lineWidth: 2)
                    .frame(width: width * 0.8, height: height)

                VStack(spacing: 8) {
                    Image(systemName: "doc.text")
                        .font(.system(size: 48))
                        .foregroundColor(.white.opacity(0.3))
                    Text("Sample Page")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.4))

                    // Text line silhouettes
                    VStack(spacing: 6) {
                        ForEach(0..<5, id: \.self) { _ in
                            RoundedRectangle(cornerRadius: 2)
                                .fill(Color.white.opacity(0.15))
                                .frame(width: width * 0.5, height: 3)
                        }
                    }
                    .padding(.top, 8)
                }
            }

        case .insideCoverBack:
            // Open book showing inside back cover
            ZStack {
                HStack(spacing: 2) {
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.white.opacity(0.3), lineWidth: 1)
                        .frame(width: width * 0.48, height: height)

                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.white.opacity(0.6), lineWidth: 2)
                        .frame(width: width * 0.48, height: height)
                }

                VStack(spacing: 12) {
                    Image(systemName: "book.pages")
                        .font(.system(size: 48))
                        .foregroundColor(.white.opacity(0.3))
                    Text("Inside Back Cover")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.4))
                }
            }

        case .backCover:
            // Book back cover silhouette
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.white.opacity(0.6), lineWidth: 2)
                    .frame(width: width, height: height)

                VStack(spacing: 12) {
                    Image(systemName: "book.closed.fill")
                        .font(.system(size: 48))
                        .foregroundColor(.white.opacity(0.3))
                    Text("Back Cover")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.4))

                    // Barcode silhouette
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                        .frame(width: 80, height: 50)
                        .overlay(
                            Image(systemName: "barcode")
                                .foregroundColor(.white.opacity(0.2))
                        )
                }
            }
        }
    }
}

// MARK: - Camera Model

class CameraModel: NSObject, ObservableObject {
    @Published var session = AVCaptureSession()
    @Published var isAuthorized = false

    private let output = AVCapturePhotoOutput()
    private var photoContinuation: ((UIImage?) -> Void)?

    func checkPermissions() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            setupCamera()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                if granted {
                    DispatchQueue.main.async {
                        self?.setupCamera()
                    }
                }
            }
        default:
            break
        }
    }

    private func setupCamera() {
        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else { return }

        do {
            let input = try AVCaptureDeviceInput(device: device)

            session.beginConfiguration()

            if session.canAddInput(input) {
                session.addInput(input)
            }
            if session.canAddOutput(output) {
                session.addOutput(output)
            }

            session.commitConfiguration()

            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                self?.session.startRunning()
            }

            isAuthorized = true
        } catch {
            print("Camera setup error: \(error)")
        }
    }

    func capturePhoto(completion: @escaping (UIImage?) -> Void) {
        photoContinuation = completion
        let settings = AVCapturePhotoSettings()
        output.capturePhoto(with: settings, delegate: self)
    }
}

extension CameraModel: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let data = photo.fileDataRepresentation(),
              let image = UIImage(data: data) else {
            photoContinuation?(nil)
            return
        }
        DispatchQueue.main.async { [weak self] in
            self?.photoContinuation?(image)
        }
    }
}

// MARK: - Camera Preview

struct CameraPreview: UIViewRepresentable {
    @ObservedObject var camera: CameraModel

    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: UIScreen.main.bounds)

        let previewLayer = AVCaptureVideoPreviewLayer(session: camera.session)
        previewLayer.frame = view.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)

        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        if let layer = uiView.layer.sublayers?.first as? AVCaptureVideoPreviewLayer {
            layer.frame = uiView.bounds
        }
    }
}
