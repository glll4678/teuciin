import SwiftUI

extension Font {

        static let fixedWidth: Font = {
                if #available(iOS 15.0, macOS 12.0, *) {
                        return Font.body.monospaced()
                } else {
                        return Font.system(.body, design: .monospaced)
                }
        }()

        static let master: Font = {
                #if os(iOS)
                return Font.body
                #else
                return constructFont(size: 13)
                #endif
        }()
        static let masterHeadline: Font = {
                #if os(iOS)
                return Font.body.weight(.medium)
                #else
                return constructFont(size: 15)
                #endif
        }()

        #if os(macOS)
        private static func constructFont(size: CGFloat) -> Font {
                let primary: String = {
                        if let _ = NSFont(name: "SF Pro", size: size) {
                                return "SF Pro"
                        } else {
                                return "Helvetica Neue"
                        }
                }()
                let fallbacks: [String] = {
                        var list: [String] = ["PingFang HK"]
                        let firstWave: [String] = ["ChiuKong Gothic CL", "Advocate Ancient Sans", "Source Han Sans K", "Noto Sans CJK KR", "Sarasa Gothic CL"]
                        for name in firstWave {
                                if let _ = NSFont(name: name, size: size) {
                                        list = [name]
                                        break
                                }
                        }
                        let secondWave: [String] = ["I.MingCP", "I.Ming"]
                        for item in secondWave {
                                if let _ = NSFont(name: item, size: size) {
                                        list.append(item)
                                        break
                                }
                        }
                        if let _ = NSFont(name: "HanaMinB", size: size) {
                                list.append("HanaMinB")
                        }
                        return list
                }()
                let shouldUseSystemFonts: Bool = primary == "Helvetica Neue" && fallbacks == ["PingFang HK"]
                if shouldUseSystemFonts {
                        return Font.system(size: size)
                } else {
                        return pairFonts(primary: primary, fallbacks: fallbacks, size: size)
                }
        }
        #endif

        #if os(macOS)
        private static func pairFonts(primary name: String, fallbacks: [String], size: CGFloat) -> Font {
                let originalFont: NSFont = NSFont(name: name, size: size) ?? .systemFont(ofSize: size)
                let originalDescriptor: NSFontDescriptor = originalFont.fontDescriptor
                let fallbackDescriptors: [NSFontDescriptor] = fallbacks.map { fontName -> NSFontDescriptor in
                        return originalDescriptor.addingAttributes([.name: fontName])
                }
                let pairedDescriptor: NSFontDescriptor = originalDescriptor.addingAttributes([.cascadeList : fallbackDescriptors])
                let pairedFont: NSFont = NSFont(descriptor: pairedDescriptor, size: size) ?? .systemFont(ofSize: size)
                return Font(pairedFont)
        }
        #endif
}
