#if os(iOS)

import SwiftUI

struct IOSContentView: View {

        @State private var selection: Int = 0

        var body: some View {
                TabView(selection: $selection) {
                        HomeView()
                                .tabItem {
                                        Label("Home", systemImage: "house").environment(\.symbolVariants, .none)
                                }
                                .tag(0)
                }
                .onAppear {
                        UITextField.appearance().clearButtonMode = .always
                }
        }
}

#endif
