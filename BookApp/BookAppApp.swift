import SwiftUI

@main
struct BookAppApp: App {
    @State private var viewModel = AuthViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
                .onOpenURL { url in
                    handleDeepLink(url)
                }
        }
    }

    private func handleDeepLink(_ url: URL) {
        guard url.scheme == "worm",
              url.host == "store",
              let storeId = url.pathComponents.dropFirst().first else { return }

        if let seller = viewModel.demoSellers.first(where: {
            $0.id == storeId
        }) {
            viewModel.sellerStoreToView = seller
            viewModel.selectedTab = 0
        }
    }
}
