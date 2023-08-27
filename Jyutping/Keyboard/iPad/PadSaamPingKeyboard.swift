import SwiftUI

struct PadSaamPingKeyboard: View {

        @EnvironmentObject private var context: KeyboardViewController

        var body: some View {
                VStack(spacing: 0) {
                        if context.inputStage.isBuffering {
                                CandidateScrollBar()
                        } else {
                                ToolBar()
                        }
                        HStack(spacing: 0 ) {
                                Group {
                                        PadExpansibleInputKey(keyLocale: .leading, keyModel: KeyModel(primary: KeyElement("aa"), members: [KeyElement("aa"), KeyElement("q")]))
                                        PadPullableInputKey(upper: "2", lower: "w")
                                        PadPullableInputKey(upper: "3", lower: "e")
                                        PadExpansibleInputKey(keyLocale: .leading, keyModel: KeyModel(primary: KeyElement("oe"), members: [KeyElement("oe"), KeyElement("r"), KeyElement("eo")]))
                                        PadPullableInputKey(upper: "5", lower: "t")
                                        PadExpansibleInputKey(keyLocale: .trailing, keyModel: KeyModel(primary: KeyElement("yu"), members: [KeyElement("yu"), KeyElement("y")]))
                                        PadPullableInputKey(upper: "7", lower: "u")
                                        PadPullableInputKey(upper: "8", lower: "i")
                                        PadPullableInputKey(upper: "9", lower: "o")
                                        PadPullableInputKey(upper: "0", lower: "p")
                                }
                                PadBackspaceKey(widthUnitTimes: 1)
                        }
                        HStack(spacing: 0) {
                                PlaceholderKey()
                                Group {
                                        PadPullableInputKey(upper: "@", lower: "a")
                                        PadPullableInputKey(upper: "#", lower: "s")
                                        PadPullableInputKey(upper: "$", lower: "d")
                                        PadPullableInputKey(upper: "/", lower: "f")
                                        PadPullableInputKey(upper: "（", lower: "g")
                                        PadPullableInputKey(upper: "）", lower: "h")
                                        PadPullableInputKey(upper: "「", lower: "j")
                                        PadPullableInputKey(upper: "」", lower: "k")
                                        PadPullableInputKey(upper: "'", lower: "l")
                                }
                                PadReturnKey(widthUnitTimes: 1.5)
                        }
                        HStack(spacing: 0) {
                                PadShiftKey(widthUnitTimes: 1)
                                Group {
                                        PadExpansibleInputKey(keyLocale: .leading, keyModel: KeyModel(primary: KeyElement("z", header: "1"), members: [KeyElement("z"), KeyElement("1", footer: "陰平")]))
                                        PadExpansibleInputKey(keyLocale: .leading, keyModel: KeyModel(primary: KeyElement("gw", header: "2"), members: [KeyElement("gw"), KeyElement("2", footer: "陰上"), KeyElement("x")]))
                                        PadExpansibleInputKey(keyLocale: .leading, keyModel: KeyModel(primary: KeyElement("c", header: "3"), members: [KeyElement("c"), KeyElement("3", footer: "陰去")]))
                                        PadExpansibleInputKey(keyLocale: .leading, keyModel: KeyModel(primary: KeyElement("ng", header: "4"), members: [KeyElement("ng"), KeyElement("4", footer: "陽平"), KeyElement("v")]))
                                        PadExpansibleInputKey(keyLocale: .trailing, keyModel: KeyModel(primary: KeyElement("b", header: "5"), members: [KeyElement("b"), KeyElement("5", footer: "陽上")]))
                                        PadExpansibleInputKey(keyLocale: .trailing, keyModel: KeyModel(primary: KeyElement("n", header: "6"), members: [KeyElement("n"), KeyElement("6", footer: "陽去")]))
                                        PadExpansibleInputKey(keyLocale: .trailing, keyModel: KeyModel(primary: KeyElement("m"), members: [KeyElement("m"), KeyElement("kw")]))
                                }
                                if context.keyboardCase.isUppercased {
                                        PadExpansibleInputKey(keyLocale: .trailing, keyModel: KeyModel(primary: KeyElement("！"), members: [KeyElement("！"), KeyElement("!", header: "半形")]))
                                        PadExpansibleInputKey(keyLocale: .trailing, keyModel: KeyModel(primary: KeyElement("？"), members: [KeyElement("？"), KeyElement("?", header: "半形")]))
                                } else {
                                        PadUpperLowerInputKey(keyLocale: .trailing, upper: "！", lower: "，", keyModel: KeyModel(primary: KeyElement("，"), members: [KeyElement("，"), KeyElement("！"), KeyElement(",", header: "半形"), KeyElement("!", header: "半形")]))
                                        PadUpperLowerInputKey(keyLocale: .trailing, upper: "？", lower: "。", keyModel: KeyModel(primary: KeyElement("。"), members: [KeyElement("。"), KeyElement("？"), KeyElement(".", header: "半形"), KeyElement("?", header: "半形")]))
                                }
                                PadShiftKey(widthUnitTimes: 1)
                        }
                        HStack(spacing: 0) {
                                if context.needsInputModeSwitchKey {
                                        PadGlobeKey(widthUnitTimes: 1.5)
                                } else {
                                        PadTransformKey(destination: .numeric, widthUnitTimes: 1.5)
                                }
                                PadTransformKey(destination: .numeric, widthUnitTimes: 1.5)
                                PadSpaceKey()
                                PadTransformKey(destination: .numeric, widthUnitTimes: 1.5)
                                PadDismissKey(widthUnitTimes: 1.5)
                        }
                }
        }
}
