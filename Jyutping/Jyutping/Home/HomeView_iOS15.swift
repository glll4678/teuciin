import SwiftUI
import JyutpingProvider

@available(iOS 15.0, *)
struct HomeView_iOS15: View {

        @State private var inputText: String = .empty
        @State private var cantonese: String = .empty
        @State private var pronunciations: [String] = []

        @State private var isKeyboardEnabled: Bool = {
                guard let keyboards: [String] = UserDefaults.standard.object(forKey: "AppleKeyboards") as? [String] else { return false }
                return keyboards.contains("im.cantonese.CantoneseIM.Keyboard")
        }()
        @State private var isGuideViewExpanded: Bool = false

        // Tones Input Section
        private let dotText: Text = Text(verbatim: "•")
        private let tonesInputContent: String = NSLocalizedString("v = 1 陰平， vv = 4 陽平\nx = 2 陰上， xx = 5 陽上\nq = 3 陰去， qq = 6 陽去", comment: .empty)

        var body: some View {
                NavigationView {
                        List {
                                Section {
                                        TextField("Text Field", text: $inputText)
                                                .autocapitalization(.none)
                                                .disableAutocorrection(true)
                                                .onSubmit {
                                                        let newInput: String = inputText.filtered()
                                                        if cantonese != newInput {
                                                                cantonese = newInput
                                                                pronunciations = newInput.isEmpty ? [] : JyutpingProvider.search(for: newInput)
                                                        }
                                                }
                                }
                                if !cantonese.isEmpty && !pronunciations.isEmpty {
                                        Section {
                                                Button {
                                                        Speaker.speak(cantonese)
                                                } label: {
                                                        HStack {
                                                                Text(verbatim: cantonese).foregroundColor(.primary)
                                                                Spacer()
                                                                Image.speaker
                                                        }
                                                }
                                                ForEach(pronunciations, id: \.self) { romanization in
                                                        Button {
                                                                Speaker.speak(romanization)
                                                        } label: {
                                                                HStack(spacing: 16) {
                                                                        Text(verbatim: romanization).foregroundColor(.primary)
                                                                        if cantonese.count == 1 {
                                                                                Text(verbatim: Syllable2IPA.IPAText(romanization)).foregroundColor(.secondary)
                                                                        }
                                                                        Spacer()
                                                                        Image.speaker
                                                                }
                                                        }
                                                }
                                        }
                                        .textSelection(.enabled)
                                }
                                Section {
                                        if isKeyboardEnabled {
                                                HStack {
                                                        Text("How to enable this Keyboard")
                                                        Spacer()
                                                        if isGuideViewExpanded {
                                                                Image(systemName: "chevron.down")
                                                        } else {
                                                                Image(systemName: "chevron.left")
                                                        }
                                                }
                                                .contentShape(Rectangle())
                                                .onTapGesture {
                                                        isGuideViewExpanded.toggle()
                                                }
                                        } else {
                                                Text("How to enable this Keyboard").font(.headline)
                                        }
                                        if !isKeyboardEnabled || isGuideViewExpanded {
                                                VStack(spacing: 5) {
                                                        HStack {
                                                                dotText
                                                                Text("Jump to **Settings**")
                                                                Spacer()
                                                        }
                                                        HStack {
                                                                dotText
                                                                Text("Tap **Keyboards**")
                                                                Spacer()
                                                        }
                                                        HStack {
                                                                dotText
                                                                Text("Turn on **Jyutping**")
                                                                Spacer()
                                                        }
                                                        HStack {
                                                                dotText
                                                                Text("Turn on **Allow Full Access**")
                                                                Spacer()
                                                        }
                                                }
                                        }
                                }
                                if !isKeyboardEnabled || isGuideViewExpanded {
                                        Section {
                                                Button {
                                                        guard let url: URL = URL(string: UIApplication.openSettingsURLString) else { return }
                                                        UIApplication.shared.open(url)
                                                } label: {
                                                        HStack{
                                                                Spacer()
                                                                Text("Go to **Settings**")
                                                                Spacer()
                                                        }
                                                }
                                        }
                                }
                                Group {
                                        Section {
                                                Text("Tones Input").font(.headline)
                                                Text(tonesInputContent)
                                                        .font(.body.monospaced())
                                                        .lineSpacing(5)
                                                        .fixedSize(horizontal: true, vertical: false)
                                                        .contextMenu {
                                                                MenuCopyButton(tonesInputContent)
                                                        }
                                        }
                                        Section {
                                                Text("Lookup Jyutping with Cangjie").font(.headline)
                                                Text("以 v 開始，再輸入倉頡碼即可。例如輸入 vdam 就會出「查」等。候選詞會帶顯示對應嘅粵拼。").lineSpacing(6).textSelection(.enabled)
                                        }
                                        Section {
                                                Text("Lookup Jyutping with Stroke").font(.headline)
                                                Text("以 x 開始，再輸入筆畫碼即可。例如輸入 xwsad 就會出「木」等。候選詞會帶顯示對應嘅粵拼。").lineSpacing(6).textSelection(.enabled)
                                                Text("""
                                                w = 橫(waang)
                                                s = 豎(syu)
                                                a = 撇
                                                d = 點(dim)
                                                z = 折(zit)
                                                """)
                                                        .font(.body.monospaced())
                                                        .lineSpacing(6)
                                                        .contextMenu {
                                                                Button(action: {
                                                                        let rules: String = """
                                                                        w = 橫(waang)
                                                                        s = 豎(syu)
                                                                        a = 撇
                                                                        d = 點(dim)
                                                                        z = 折(zit)
                                                                        """
                                                                        UIPasteboard.general.string = rules
                                                                }) {
                                                                        Label("Copy", systemImage: "doc.on.doc")
                                                                }
                                                        }
                                        }
                                        Section {
                                                Text("Lookup Jyutping with Pinyin").font(.headline)
                                                Text("以 r 開始，再輸入普通話拼音即可。例如輸入 rcha 就會出「查」等。候選詞會帶顯示對應嘅粵拼。").lineSpacing(6).textSelection(.enabled)
                                        }
                                        Section {
                                                Text("Period (Full Stop) Shortcut").font(.headline)
                                                Text("Double tapping the space bar will insert a period followed by a space").lineSpacing(6).textSelection(.enabled)
                                        }
                                }
                                Section {
                                        Text("Can I use with external keyboards?").font(.headline)
                                        Text("Unfortunately not. Third-party keyboard apps can't communicate with external keyboards due to system limitations.").lineSpacing(6).textSelection(.enabled)
                                }
                                Section {
                                        NavigationLink(destination: ExpressionsView()) {
                                                Label("Cantonese Expressions", systemImage: "checkmark.seal")
                                        }
                                }
                                /*
                                Group {
                                        Section {
                                                NavigationLink(destination: IntroductionsView()) {
                                                        Label("More Introductions", systemImage: "info.circle")
                                                }
                                        }
                                        Section {
                                                NavigationLink(destination: FAQView()) {
                                                        Label("Frequently Asked Questions", systemImage: "questionmark.circle")
                                                }
                                        }
                                }
                                */
                        }
                        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
                                guard let keyboards: [String] = UserDefaults.standard.object(forKey: "AppleKeyboards") as? [String] else { return }
                                let isContained: Bool =  keyboards.contains("im.cantonese.CantoneseIM.Keyboard")
                                if isKeyboardEnabled != isContained {
                                        isKeyboardEnabled = isContained
                                }
                        }
                        .navigationTitle("Home")
                }
                .navigationViewStyle(.stack)
        }
}


@available(iOS 15.0, *)
struct HomeView_iOS15_Previews: PreviewProvider {
        static var previews: some View {
                HomeView_iOS15()
        }
}