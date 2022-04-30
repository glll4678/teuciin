import SwiftUI

struct MacContentView: View {
        var body: some View {
                NavigationView {
                        List {
                                Section {
                                        NavigationLink(destination: MacIntroductionsView()) {
                                                Label("Introductions", systemImage: "book")
                                        }
                                        NavigationLink(destination: ExpressionsView().textSelection(.enabled)) {
                                                Label("title.expressions", systemImage: "text.quote")
                                        }
                                } header: {
                                        Text("Keyboard").textCase(.none)
                                }
                                Section {
                                        NavigationLink(destination: MacSearchView()) {
                                                Label("Search", systemImage: "magnifyingglass")
                                        }
                                        NavigationLink(destination: InitialsTable()) {
                                                Label("Initials", systemImage: "rectangle.leadingthird.inset.filled")
                                        }
                                        NavigationLink(destination: FinalsTable()) {
                                                Label("Finals", systemImage: "rectangle.trailingthird.inset.filled")
                                        }
                                        NavigationLink(destination: TonesTable()) {
                                                Label("Tones", systemImage: "bell")
                                        }
                                } header: {
                                        Text("Jyutping").textCase(.none)
                                }
                                Section {
                                        NavigationLink(destination: MacAboutView()) {
                                                Label("About", systemImage: "globe.asia.australia")
                                        }
                                } header: {
                                        Text("About").textCase(.none)
                                }
                        }
                        .listStyle(.sidebar)
                        .navigationTitle("Jyutping")
                }
        }
}