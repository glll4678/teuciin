import UIKit
import CoreIME

extension KeyView {

        var width: CGFloat {
                switch keyboardInterface {
                case .phonePortrait, .phoneLandscape, .padFloating:
                        switch event {
                        case .none, .hidden(.text), .hidden(.backspace):
                                return 10
                        case .globe:
                                return 45
                        case .backspace, .shift, .transform:
                                return 50
                        case .newLine:
                                return 70
                        case .space:
                                return 170
                        case .input(.comma), .input(.period), .input(.cantoneseComma), .input(.cantonesePeriod), .input(.separator):
                                return 35
                        default:
                                return 40
                        }
                case .padPortraitSmall, .padLandscapeSmall:
                        switch event {
                        case .none, .hidden(.text), .hidden(.backspace):
                                return 10
                        case .globe:
                                return 45
                        case .backspace, .shift, .transform, .dismiss:
                                return 50
                        case .newLine:
                                return 75
                        case .space:
                                return 180
                        case .input(.period), .input(.cantoneseComma), .input(.separator):
                                return 50
                        default:
                                return 40
                        }
                case .padPortraitMedium, .padLandscapeMedium:
                        switch event {
                        case .none:
                                return 10
                        case .globe:
                                return 45
                        case .backspace, .transform, .dismiss, .tab:
                                return 50
                        case .newLine:
                                return 70
                        case .shift:
                                return 60
                        case .space:
                                return 180
                        case .input(.period), .input(.cantoneseComma), .input(.separator):
                                return 50
                        default:
                                return 40
                        }
                case .padPortraitLarge, .padLandscapeLarge:
                        switch event {
                        case .none:
                                return 10
                        case .globe:
                                return 45
                        case .transform, .dismiss, .tab:
                                return 50
                        case .backspace:
                                return 60
                        case .newLine:
                                return 70
                        case .shift:
                                return 75
                        case .space:
                                return 180
                        case .input(.period), .input(.cantoneseComma), .input(.separator):
                                return 50
                        default:
                                return 40
                        }
                }
        }
        var height: CGFloat {
                switch keyboardInterface {
                case .padPortraitSmall:
                        return 65
                case .padPortraitMedium:
                        return 68
                case .padPortraitLarge:
                        return 72
                case .padLandscapeSmall, .padLandscapeMedium, .padLandscapeLarge:
                        return 80
                case .padFloating:
                        return 48
                case .phoneLandscape:
                        // iPhone SE1, iPod touch 7 (w480 x h320)
                        let isSmallPhone: Bool = UIScreen.main.bounds.size.height < 350
                        return isSmallPhone ? 36 : 40
                case .phonePortrait:
                        let screenWidth: CGFloat = UIScreen.main.bounds.size.width
                        if screenWidth < 350 {
                                // iPhone SE1, iPod touch 7 (320 x 480)
                                return 48
                        } else if screenWidth < 400 {
                                // iPhone 6s, 7, 8, SE2, SE3 (375 x 667)
                                // iPhone X, Xs, 11 Pro, 12 mini, 13 mini (375 x 812)
                                // iPhone 12, 12 Pro, 13, 13 Pro, 14 (390 x 844)
                                // iPhone 14 Pro (393 x 852)
                                return 53
                        } else {
                                // iPhone 6s Plus, 7 Plus, 8 Plus (414 x 836)
                                // iPhone Xr, Xs Max, 11, 11 Pro Max (414 x 896)
                                // iPhone 12 Pro Max, 13 Pro Max, 14 Plus (428 x 926)
                                // iPhone 14 Pro Max (430 x 932)
                                return 55
                        }
                }
        }

        /// KeyView shape.layer.cornerRadius
        var layerCornerRadius: CGFloat {
                switch keyboardInterface {
                case .phonePortrait:
                        return 5
                case .phoneLandscape:
                        return 5
                case .padFloating:
                        return 4
                case .padPortraitSmall:
                        return 6
                case .padPortraitMedium:
                        return 6
                case .padPortraitLarge:
                        return 6
                case .padLandscapeSmall:
                        return 6
                case .padLandscapeMedium:
                        return 6
                case .padLandscapeLarge:
                        return 6
                }
        }

        var keyFont: UIFont {
                // https://www.iosfontsizes.com
                // https://developer.apple.com/design/human-interface-guidelines/foundations/typography
                let size: CGFloat = {
                        switch event {
                        case .input(let seat):
                                let isMultipleCharacters: Bool = seat.primary.text.count > 1
                                switch keyboardInterface {
                                case .padLandscapeSmall, .padLandscapeMedium, .padLandscapeLarge:
                                        return isMultipleCharacters ? 26 : 28
                                case .padPortraitSmall, .padPortraitMedium, .padPortraitLarge:
                                        return isMultipleCharacters ? 24 : 26
                                default:
                                        return isMultipleCharacters ? 18 : 24
                                }
                        case .space, .newLine:
                                switch keyboardInterface {
                                case .padLandscapeSmall, .padLandscapeMedium, .padLandscapeLarge:
                                        return 20
                                case .padPortraitSmall, .padPortraitMedium, .padPortraitLarge:
                                        return 18
                                default:
                                        return 16
                                }
                        default:
                                switch keyboardInterface {
                                case .padLandscapeSmall, .padLandscapeMedium, .padLandscapeLarge:
                                        return 20
                                case .padPortraitSmall, .padPortraitMedium, .padPortraitLarge:
                                        return 18
                                default:
                                        return 17
                                }
                        }
                }()
                return UIFont.systemFont(ofSize: size)
        }
        var keyText: String? {
                switch event {
                case .input(let seat):
                        return seat.primary.text
                case .space:
                        if layout.isEnglishMode {
                                return "ABC"
                        } else if Logogram.current == .simplified {
                                return "粤拼·简化字"
                        } else {
                                return "粵拼"
                        }
                case .newLine:
                        return newLineKeyText
                case .transform(let newLayout):
                        switch newLayout {
                        case .cantoneseNumeric, .numeric:
                                return keyboardInterface.isCompact ? "123" : ".?123"
                        case .cantoneseSymbolic, .symbolic:
                                return "#+="
                        case .cantonese:
                                return "拼"
                        case .alphabetic:
                                return "ABC"
                        default:
                                return "??"
                        }
                default:
                        return nil
                }
        }
        private var newLineKeyText: String {
                guard !layout.isEnglishMode else {
                        guard let returnKeyType: UIReturnKeyType = controller.textDocumentProxy.returnKeyType else { return "return" }
                        switch returnKeyType {
                        case .continue:
                                return "continue"
                        case .default:
                                return "return"
                        case .done:
                                return "done"
                        case .emergencyCall:
                                return "emergency"
                        case .go:
                                return "go"
                        case .google:
                                return "google"
                        case .join:
                                return "join"
                        case .next:
                                return "next"
                        case .route:
                                return "route"
                        case .search:
                                return "search"
                        case .send:
                                return "send"
                        case .yahoo:
                                return "yahoo"
                        @unknown default:
                                return "return"
                        }
                }
                guard Logogram.current != .simplified else {
                        guard let returnKeyType: UIReturnKeyType = controller.textDocumentProxy.returnKeyType else { return "换行" }
                        switch returnKeyType {
                        case .continue:
                                return "继续"
                        case .default:
                                return "换行"
                        case .done:
                                return "完成"
                        case .emergencyCall:
                                return "紧急"
                        case .go:
                                return "前往"
                        case .google:
                                return "谷歌"
                        case .join:
                                return "加入"
                        case .next:
                                return "下一个"
                        case .route:
                                return "路线"
                        case .search:
                                return "搜寻"
                        case .send:
                                return "传送"
                        case .yahoo:
                                return "雅虎"
                        @unknown default:
                                return "换行"
                        }
                }
                guard let returnKeyType: UIReturnKeyType = controller.textDocumentProxy.returnKeyType else { return "換行" }
                switch returnKeyType {
                case .continue:
                        return "繼續"
                case .default:
                        return "換行"
                case .done:
                        return "完成"
                case .emergencyCall:
                        return "緊急"
                case .go:
                        return "前往"
                case .google:
                        return "谷歌"
                case .join:
                        return "加入"
                case .next:
                        return "下一個"
                case .route:
                        return "路線"
                case .search:
                        return "搜尋"
                case .send:
                        return "傳送"
                case .yahoo:
                        return "雅虎"
                @unknown default:
                        return "換行"
                }
        }

        var keyImageName: String? {
                switch event {
                case .globe:
                        return "globe"
                case .backspace:
                        return "delete.left"
                case .shift:
                        switch layout {
                        case .cantonese(.uppercased), .alphabetic(.uppercased):
                                return "shift.fill"
                        case .cantonese(.capsLocked), .alphabetic(.capsLocked):
                                return "capslock.fill"
                        default:
                                return "shift"
                        }
                case .dismiss:
                        return "keyboard.chevron.compact.down"
                case .tab:
                        return "arrow.right.to.line"
                default:
                        return nil
                }
        }

        var shapeColor: UIColor {
                if isDarkAppearance {
                        return deepDarkFantasy ? UIColor(white: 1, alpha: 0.15) : UIColor(white: 1, alpha: 0.35)
                } else {
                        return deepDarkFantasy ? .lightEmphatic : .white
                }
        }
        var backColor: UIColor {
                if isDarkAppearance {
                        return deepDarkFantasy ? .darkThick : .darkThin
                } else {
                        return deepDarkFantasy ? .lightEmphatic : .white
                }
        }
        var highlightingBackColor: UIColor {
                // action <=> non-action
                if isDarkAppearance {
                        return deepDarkFantasy ? .darkThin : .black
                } else {
                        return deepDarkFantasy ? .white : .lightEmphatic
                }
        }
        var deepDarkFantasy: Bool {
                switch event {
                case .input, .space:
                        return false
                default:
                        return true
                }
        }
        var foreColor: UIColor {
                return isDarkAppearance ? .white : .black
        }
}
