#if os(iOS)

import SwiftUI

struct JyutpingView: View {

        @State private var inputText: String = ""
        @State private var cantonese: String = ""
        @State private var pronunciations: [String] = []

        private let searchIcon: String = "doc.text.magnifyingglass"

        var body: some View {
                NavigationView {
                        List {
                                Section {
                                        TextField("Lookup Jyutping for Cantonese", text: $inputText)
                                                .textInputAutocapitalization(.never)
                                                .autocorrectionDisabled(true)
                                                .submitLabel(.search)
                                                .onSubmit {
                                                        let trimmedInput: String = inputText.trimmingCharacters(in: .whitespacesAndNewlines).trimmingCharacters(in: .controlCharacters)
                                                        guard !trimmedInput.isEmpty else {
                                                                cantonese = ""
                                                                pronunciations = []
                                                                return
                                                        }
                                                        guard trimmedInput != cantonese else { return }
                                                        let search = AppMaster.lookup(text: trimmedInput)
                                                        if search.romanizations.isEmpty {
                                                                cantonese = trimmedInput
                                                                pronunciations = []
                                                        } else {
                                                                cantonese = search.text
                                                                pronunciations = search.romanizations
                                                        }
                                                }
                                }
                                if !cantonese.isEmpty {
                                        Section {
                                                HStack {
                                                        Text(verbatim: cantonese)
                                                        Spacer()
                                                        Speaker(cantonese)
                                                }
                                                ForEach(0..<pronunciations.count, id: \.self) { index in
                                                        let romanization: String = pronunciations[index]
                                                        HStack(spacing: 16) {
                                                                Text(verbatim: romanization)
                                                                if cantonese.count == 1 {
                                                                        Text(verbatim: Syllable2IPA.IPAText(romanization)).foregroundColor(.secondary)
                                                                }
                                                                Spacer()
                                                                Speaker(romanization)
                                                        }
                                                }
                                        }
                                        .textSelection(.enabled)
                                }

                                Section {
                                        NavigationLink(destination: InitialsTable()) {
                                                Label("Jyutping Initials", systemImage: "tablecells")
                                        }
                                        NavigationLink(destination: FinalsTable()) {
                                                Label("Jyutping Finals", systemImage: "tablecells")
                                        }
                                        NavigationLink(destination: TonesTable()) {
                                                Label("Jyutping Tones", systemImage: "tablecells")
                                        }
                                }
                                .labelStyle(.titleOnly)

                                Section {
                                        ExtendedLinkLabel(icon: searchIcon, title: "粵音資料集叢", footnote: "jyut.net", address: "https://jyut.net")
                                        ExtendedLinkLabel(icon: searchIcon, title: "粵典", footnote: "words.hk", address: "https://words.hk")
                                        ExtendedLinkLabel(icon: searchIcon, title: "粵語審音配詞字庫", footnote: "humanum.arts.cuhk.edu.hk/Lexis/lexi-can", address: "https://humanum.arts.cuhk.edu.hk/Lexis/lexi-can")
                                        ExtendedLinkLabel(icon: searchIcon, title: "泛粵大典", footnote: "www.jyutdict.org", address: "https://www.jyutdict.org")
                                        ExtendedLinkLabel(icon: searchIcon, title: "羊羊粵語", footnote: "shyyp.net/hant", address: "https://shyyp.net/hant")
                                }

                                Section {
                                        ExtendedLinkLabel(title: "粵拼 Jyutping", footnote: "jyutping.org", address: "https://jyutping.org")
                                        ExtendedLinkLabel(title: "粵語拼音速遞 - CUHK", footnote: "ilc.cuhk.edu.hk/workshop/Chinese/Cantonese/Romanization", address: "https://www.ilc.cuhk.edu.hk/workshop/Chinese/Cantonese/Romanization")
                                }
                        }
                        .animation(.default, value: cantonese)
                        .navigationTitle("Jyutping")
                }
                .navigationViewStyle(.stack)
        }
}

#endif