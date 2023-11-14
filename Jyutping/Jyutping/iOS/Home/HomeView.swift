#if os(iOS)

import SwiftUI

struct HomeView: View {

        @State private var animationState: Int = 0

        @State private var isKeyboardEnabled: Bool = {
                guard let keyboards: [String] = UserDefaults.standard.object(forKey: "AppleKeyboards") as? [String] else { return false }
                return keyboards.contains("tw.tauhu.Teuciin.Kienpan")
        }()
        @State private var isGuideViewExpanded: Bool = false

        private var shouldDisplayHapticFeedbackTip: Bool {
                guard Device.isPhone else { return false }
                return !isKeyboardEnabled || isGuideViewExpanded
        }

        var body: some View {
                NavigationView {
                        List {
                                Section {
                                        if isKeyboardEnabled {
                                                HStack {
                                                        Text("How to enable this Keyboard")
                                                        Spacer()
                                                        if isGuideViewExpanded {
                                                                Image.downChevron
                                                        } else {
                                                                Image.backwardChevron
                                                        }
                                                }
                                                .contentShape(Rectangle())
                                                .onTapGesture {
                                                        isGuideViewExpanded.toggle()
                                                }
                                        } else {
                                                Text("How to enable this Keyboard").font(.significant)
                                        }
                                        if !isKeyboardEnabled || isGuideViewExpanded {
                                                VStack(spacing: 5) {
                                                        HStack {
                                                                Text.dotMark
                                                                Text("Jump to **Settings**")
                                                                Spacer()
                                                        }
                                                        HStack {
                                                                Text.dotMark
                                                                Text("Tap **Keyboards**")
                                                                Spacer()
                                                        }
                                                        HStack {
                                                                Text.dotMark
                                                                Text("Turn on **Jyutping**")
                                                                Spacer()
                                                        }
                                                        HStack {
                                                                Text.dotMark
                                                                Text("Turn on **Allow Full Access**")
                                                                Spacer()
                                                        }
                                                }
                                                .accessibilityLabel("accessibility.how_to_enable_this_keyboard")
                                        }
                                } footer: {
                                        Text("Haptic Feedback requires Full Access")
                                                .textCase(nil)
                                                .opacity(shouldDisplayHapticFeedbackTip ? 1 : 0)
                                }
                                if !isKeyboardEnabled || isGuideViewExpanded {
                                        Section {
                                                Link(destination: URL(string: UIApplication.openSettingsURLString)!) {
                                                        HStack {
                                                                Spacer()
                                                                Text("Go to **Settings**")
                                                                Spacer()
                                                        }
                                                }
                                        }
                                }

                                Group {
                                        Section {
                                                Text("Tones Input").font(.significant)
                                                Text("tones.input.description")
                                                        .font(.fixedWidth)
                                                        .lineSpacing(5)
                                                        .fixedSize(horizontal: true, vertical: false)
                                                Text("tones.input.examples")
                                        }
                                        Section {
                                                Text("Lookup Jyutping with Cangjie").font(.significant)
                                                Text("Cangjie Reverse Lookup Description").lineSpacing(6)
                                        }
                                        Section {
                                                Text("Credit").font(.significant)
                                                NoteView("credit.1")
                                                NoteView("credit.2")
                                        }
                                }
                                .textSelection(.enabled)

                        }
                        .animation(.default, value: animationState)
                        .animation(.default, value: isGuideViewExpanded)
                        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
                                guard let keyboards: [String] = UserDefaults.standard.object(forKey: "AppleKeyboards") as? [String] else { return }
                                let isContained: Bool =  keyboards.contains("tw.tauhu.Teuciin.Kienpan")
                                if isKeyboardEnabled != isContained {
                                        isKeyboardEnabled = isContained
                                }
                        }
                        .navigationTitle("Home")
                }
                .navigationViewStyle(.stack)
        }
}

private struct NoteView: View {

        init(_ text: LocalizedStringKey) {
                self.text = text
        }

        private let text: LocalizedStringKey

        var body: some View {
                HStack {
                        Text.dotMark
                        Text(text)
                        Spacer()
                }
        }
}

#endif
