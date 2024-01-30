import SwiftUI

enum Tab {
    case popular
    case favorite
}

struct RootView: View {
    var body: some View {
        TabView {
            PopularView()
                .tag(Tab.popular)
                .tabItem {
                    Label(
                        title: { Text("popular") },
                        icon: { Image(systemName: "crown.fill") }
                    )
                }

            FavoriteView()
                .tag(Tab.favorite)
                .tabItem {
                    Label(
                        title: { Text("favorite") },
                        icon: { Image(systemName: "list.star") }
                    )
                }
        }
    }
}

#Preview {
    RootView()
}

