import SwiftUI

struct InitialsTable: View {

        @Environment(\.horizontalSizeClass) var horizontalSize

        private var width: CGFloat {
                if Device.isPhone {
                        return (UIScreen.main.bounds.width - 64) / 3.0
                } else if horizontalSize == .compact {
                        return 90
                } else {
                        return 120
                }
        }

        var body: some View {
                if #available(iOS 15.0, *) {
                        List(0..<dataLines.count, id: \.self) { index in
                                SyllableCell(dataLines[index], width: width)
                        }
                        .font(.body.monospaced())
                        .textSelection(.enabled)
                        .navigationTitle("Jyutping Initials")
                        .navigationBarTitleDisplayMode(.inline)
                } else {
                        List(0..<dataLines.count, id: \.self) { index in
                                SyllableCell(dataLines[index], width: width)
                        }
                        .font(.system(.body, design: .monospaced))
                        .listStyle(.insetGrouped)
                        .navigationTitle("Jyutping Initials")
                        .navigationBarTitleDisplayMode(.inline)
                }
        }

        private var dataLines: [String] {
                return sourceText.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines).map({ $0.trimmingCharacters(in: .whitespaces) })
        }


private let sourceText: String = """
例字,IPA,粵拼
巴 baa1,[p],b
趴 paa1,[pʰ],p
媽 maa1,[m],m
花 faa1,[f],f
打 daa2,[t],d
他 taa1,[tʰ],t
拿 naa4,[n],n
啦 laa1,[l],l
家 gaa1,[k],g
卡 kaa1,[kʰ],k
牙 ngaa4,[ŋ],ng
蝦 haa1,[h],h
瓜 gwaa1,[kʷ],gw
夸 kwaa1,[kʷʰ],kw
娃 waa1,[w],w
渣 zaa1,t͡s~t͡ʃ,z
叉 caa1,t͡sʰ~t͡ʃʰ,c
沙 saa1,s~ʃ,s
也 jaa5,[j],j
"""


}

