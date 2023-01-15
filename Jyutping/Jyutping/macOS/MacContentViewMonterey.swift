#if os(macOS)

import SwiftUI

@available(macOS, deprecated: 13, message: "Use MacContentView instead")
struct MacContentViewMonterey: View {

        @State private var isMacSearchViewActive: Bool = true

        var body: some View {
                NavigationView {
                        List {
                                Section {
                                        NavigationLink {
                                                MacInputMethodInstallationView().visualEffect()
                                        } label: {
                                                Label("Install Input Method", systemImage: "laptopcomputer.and.arrow.down")
                                        }
                                        NavigationLink {
                                                MacIntroductionsView().visualEffect()
                                        } label: {
                                                Label("Introductions", systemImage: "book")
                                        }
                                        NavigationLink {
                                                MacExpressionsView().textSelection(.enabled).visualEffect()
                                        } label: {
                                                Label("Cantonese Expressions", systemImage: "text.quote")
                                        }
                                } header: {
                                        Text("Input Method").textCase(nil)
                                }
                                Section {
                                        NavigationLink(destination: MacSearchView().visualEffect(), isActive: $isMacSearchViewActive) {
                                                Label("Search", systemImage: "magnifyingglass")
                                        }
                                        NavigationLink {
                                                InitialTable().visualEffect()
                                        } label: {
                                                Label("Initials", systemImage: "rectangle.leadingthird.inset.filled")
                                        }
                                        NavigationLink {
                                                FinalTable().visualEffect()
                                        } label: {
                                                Label("Finals", systemImage: "rectangle.trailingthird.inset.filled")
                                        }
                                        NavigationLink {
                                                ToneTable().visualEffect()
                                        } label: {
                                                Label("Tones", systemImage: "bell")
                                        }
                                } header: {
                                        Text("Jyutping").textCase(nil)
                                }
                                Section {
                                        NavigationLink {
                                                NumbersView().visualEffect()
                                        } label: {
                                                Label("Numbers", systemImage: "number")
                                        }
                                        NavigationLink {
                                                StemsBranchesView().visualEffect()
                                        } label: {
                                                Label("Stems and Branches", systemImage: "timelapse")
                                        }
                                        NavigationLink {
                                                ChineseZodiacView().visualEffect()
                                        } label: {
                                                Label("Chinese Zodiac", systemImage: "hare")
                                        }
                                        NavigationLink {
                                                SolarTermsView().visualEffect()
                                        } label: {
                                                Label("Solar Terms", systemImage: "cloud.sun")
                                        }
                                        NavigationLink {
                                                MacResourcesView().visualEffect()
                                        } label: {
                                                Label("Resources", systemImage: "globe.asia.australia")
                                        }
                                } header: {
                                        Text("Materials").textCase(nil)
                                }
                                Section {
                                        NavigationLink {
                                                MacAboutView().visualEffect()
                                        } label: {
                                                Label("About", systemImage: "info.circle")
                                        }
                                } header: {
                                        Text("About").textCase(nil)
                                }
                        }
                        .toolbar {
                                ToolbarItem(placement: .navigation) {
                                        Button {
                                                NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
                                        } label: {
                                                Image(systemName: "sidebar.leading")
                                        }
                                }
                        }
                        .listStyle(.sidebar)
                        .navigationTitle("Jyutping")
                }
        }
}

#endif
