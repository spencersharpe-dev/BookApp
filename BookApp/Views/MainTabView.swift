import SwiftUI

struct MainTabView: View {
    @Bindable var viewModel: AuthViewModel

    var body: some View {
        TabView(selection: $viewModel.selectedTab) {
            StoreHomeView(viewModel: viewModel)
                .tabItem {
                    Image(systemName: "storefront")
                    Text("Store")
                }
                .tag(0)

            PlaceholderTabView(title: "Listings")
                .tabItem {
                    Image(systemName: "list.bullet.rectangle")
                    Text("Listings")
                }
                .tag(1)

            EarningsView(viewModel: viewModel)
                .tabItem {
                    Image(systemName: "dollarsign.circle")
                    Text("Earnings")
                }
                .tag(2)

            ProfileView(viewModel: viewModel)
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Profile")
                }
                .tag(3)
        }
        .tint(.black)
    }
}

struct PlaceholderTabView: View {
    let title: String

    var body: some View {
        VStack {
            Spacer()
            Text(title)
                .font(.largeTitle)
                .foregroundColor(.gray)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
    }
}
