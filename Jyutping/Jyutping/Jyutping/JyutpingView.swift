import SwiftUI
import AVFoundation
import JyutpingProvider

struct JyutpingView: View {

        private let placeholder: String = NSLocalizedString("Lookup Jyutping for Cantonese", comment: "")
        @State private var inputText: String = ""

        private var rawCantonese: String { inputText.filter({ !($0.isASCII || $0.isPunctuation || $0.isWhitespace) }) }
        private var jyutpings: [String] { JyutpingProvider.search(for: rawCantonese) }

        var body: some View {
                NavigationView {
                        List {
                                Section {
                                        HStack {
                                                Image(systemName: "magnifyingglass").opacity(0.5)
                                                EnhancedTextField(placeholder: placeholder,
                                                                  text: $inputText,
                                                                  returnKey: .search,
                                                                  autocorrection: .no,
                                                                  autocapitalization: UITextAutocapitalizationType.none)
                                        }
                                }
                                if !inputText.isEmpty && jyutpings.isEmpty {
                                        Section {
                                                Text("No Results.")
                                                Text("Common Cantonese words only.").font(.footnote)
                                        }
                                } else if !inputText.isEmpty {
                                        Section {
                                                HStack {
                                                        Text(verbatim: rawCantonese)
                                                        Spacer()
                                                        Button(action: {
                                                                Speaker.speak(rawCantonese)
                                                        }) {
                                                                Image.speaker
                                                        }
                                                }
                                                ForEach(jyutpings, id: \.self) { jyutping in
                                                        HStack(spacing: 16) {
                                                                Text(verbatim: jyutping)
                                                                if rawCantonese.count == 1 {
                                                                        Text(verbatim: Syllable2IPA.IPAText(jyutping)).foregroundColor(.secondary)
                                                                }
                                                                Spacer()
                                                                Button(action: {
                                                                        Speaker.speak(jyutping)
                                                                }) {
                                                                        Image.speaker
                                                                }
                                                        }
                                                }
                                        }
                                }

                                Section {
                                        NavigationLink(destination: InitialsTable()) {
                                                Text("Jyutping Initials")
                                        }
                                        NavigationLink(destination: FinalsTable()) {
                                                Text("Jyutping Finals")
                                        }
                                        NavigationLink(destination: TonesTable()) {
                                                Text("Jyutping Tones")
                                        }
                                }

                                Section {
                                        SearchLinksView()
                                } header: {
                                        Text("Search on other places (websites)")
                                }

                                Section {
                                        JyutpingResourcesLinksView()
                                } header: {
                                        Text("Jyutping Resources")
                                }

                                Section {
                                        CantoneseResourcesLinksView()
                                } header: {
                                        Text("Cantonese Resources")
                                }
                        }
                        .listStyle(.grouped)
                        .navigationBarTitle("Jyutping")
                }
                .navigationViewStyle(.stack)
        }
}
