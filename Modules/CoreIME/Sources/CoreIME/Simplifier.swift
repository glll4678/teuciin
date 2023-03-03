import Foundation
import SQLite3

private extension Engine {
        static func matchT2S(_ character: Character) -> String {
                guard Engine.isDatabaseReady else { return String(character) }
                let code: UInt32 = character.unicodeScalars.first?.value ?? 0
                let queryString = "SELECT simplified FROM t2stable WHERE traditional = \(code);"
                var queryStatement: OpaquePointer? = nil
                defer {
                        sqlite3_finalize(queryStatement)
                }
                if sqlite3_prepare_v2(database, queryString, -1, &queryStatement, nil) == SQLITE_OK {
                        if sqlite3_step(queryStatement) == SQLITE_ROW {
                                let simplified: String = String(cString: sqlite3_column_text(queryStatement, 0))
                                return simplified
                        }
                }
                return String(character)
        }
}

struct Simplifier {

        static func convert(_ text: String) -> String {
                switch text.first {
                case .none:
                        return text
                case .some(let character) where text.count == 1:
                        return Engine.matchT2S(character)
                default:
                        return transform(text)
                }
        }

        // TODO: Reimplement with recursion
        private static func transform(_ text: String) -> String {
                let stepOne = replace(text, replacement: "X")
                guard !(stepOne.matched.isEmpty) else {
                        let newCharacters: [String] = text.map({ Engine.matchT2S($0) })
                        let transformed: String = newCharacters.joined()
                        return transformed
                }

                let stepTwo = replace(stepOne.modified, replacement: "Y")
                guard !(stepTwo.matched.isEmpty) else {
                        let newCharacters: [String] = stepTwo.modified.map({ Engine.matchT2S($0) })
                        let transformed: String = newCharacters.joined()
                        let reverted: String = transformed.replacingOccurrences(of: stepOne.replacement, with: stepOne.matched)
                        return reverted
                }

                let stepThree = replace(stepTwo.modified, replacement: "Z")
                guard !(stepThree.matched.isEmpty) else {
                        let newCharacters: [String] = stepTwo.modified.map({ Engine.matchT2S($0) })
                        let transformed: String = newCharacters.joined()
                        let reverted: String = transformed.replacingOccurrences(of: stepOne.replacement, with: stepOne.matched)
                                .replacingOccurrences(of: stepTwo.replacement, with: stepTwo.matched)
                        return reverted
                }

                let newCharacters: [String] = stepThree.modified.map({ Engine.matchT2S($0) })
                let transformed: String = newCharacters.joined()
                let reverted: String = transformed.replacingOccurrences(of: stepOne.replacement, with: stepOne.matched)
                        .replacingOccurrences(of: stepTwo.replacement, with: stepTwo.matched)
                        .replacingOccurrences(of: stepThree.replacement, with: stepThree.matched)
                return reverted
        }

        private static func replace(_ text: String, replacement: String) -> (modified: String, matched: String, replacement: String) {
                let possibleKeys: [String] = Simplifier.phrases.keys.filter({ $0.count <= text.count }).sorted(by: { $0.count > $1.count })
                lazy var modified: String = text
                lazy var matched: String = ""
                for item in possibleKeys {
                        if text.hasPrefix(item) {
                                modified = text.replacingOccurrences(of: item, with: replacement)
                                matched = Simplifier.phrases[item]!
                                break
                        }
                }
                guard matched.isEmpty else {
                        return (modified, matched, replacement)
                }
                for item in possibleKeys {
                        if text.contains(item) {
                                modified = text.replacingOccurrences(of: item, with: replacement)
                                matched = Simplifier.phrases[item]!
                                break
                        }
                }
                return (modified, matched, replacement)
        }

private static let phrases: [String: String] = [
"一目瞭然": "一目了然",
"上鍊": "上链",
"不瞭解": "不了解",
"么麼": "幺麽",
"么麽": "幺麽",
"乾乾淨淨": "干干净净",
"乾乾脆脆": "干干脆脆",
"乾元": "乾元",
"乾卦": "乾卦",
"乾嘉": "乾嘉",
"乾圖": "乾图",
"乾坤": "乾坤",
"乾坤一擲": "乾坤一掷",
"乾坤再造": "乾坤再造",
"乾坤大挪移": "乾坤大挪移",
"乾宅": "乾宅",
"乾斷": "乾断",
"乾旦": "乾旦",
"乾曜": "乾曜",
"乾清宮": "乾清宫",
"乾盛世": "乾盛世",
"乾紅": "乾红",
"乾綱": "乾纲",
"乾縣": "乾县",
"乾象": "乾象",
"乾造": "乾造",
"乾道": "乾道",
"乾陵": "乾陵",
"乾隆": "乾隆",
"乾隆年間": "乾隆年间",
"乾隆皇帝": "乾隆皇帝",
"二噁英": "二𫫇英",
"以免藉口": "以免借口",
"以功覆過": "以功复过",
"侔德覆載": "侔德复载",
"傢俱": "家具",
"傷亡枕藉": "伤亡枕藉",
"八濛山": "八濛山",
"凌藉": "凌借",
"出醜狼藉": "出丑狼藉",
"函覆": "函复",
"千鍾粟": "千锺粟",
"反反覆覆": "反反复复",
"反覆": "反复",
"反覆思維": "反复思维",
"反覆思量": "反复思量",
"反覆性": "反复性",
"名覆金甌": "名复金瓯",
"哪吒": "哪吒",
"回覆": "回复",
"壺裏乾坤": "壶里乾坤",
"大目乾連冥間救母變文": "大目乾连冥间救母变文",
"宫商角徵羽": "宫商角徵羽",
"射覆": "射复",
"尼乾陀": "尼乾陀",
"幺麼": "幺麽",
"幺麼小丑": "幺麽小丑",
"幺麼小醜": "幺麽小丑",
"康乾": "康乾",
"張法乾": "张法乾",
"彷彿": "仿佛",
"彷徨": "彷徨",
"徵弦": "徵弦",
"徵絃": "徵弦",
"徵羽摩柯": "徵羽摩柯",
"徵聲": "徵声",
"徵調": "徵调",
"徵音": "徵音",
"情有獨鍾": "情有独钟",
"憑藉": "凭借",
"憑藉着": "凭借着",
"手鍊": "手链",
"扭轉乾坤": "扭转乾坤",
"找藉口": "找借口",
"拉鍊": "拉链",
"拉鍊工程": "拉链工程",
"拜覆": "拜复",
"據瞭解": "据了解",
"文錦覆阱": "文锦复阱",
"於世成": "於世成",
"於乎": "於乎",
"於仲完": "於仲完",
"於倫": "於伦",
"於其一": "於其一",
"於則": "於则",
"於勇明": "於勇明",
"於呼哀哉": "於呼哀哉",
"於單": "於单",
"於坦": "於坦",
"於崇文": "於崇文",
"於忠祥": "於忠祥",
"於惟一": "於惟一",
"於戲": "於戏",
"於敖": "於敖",
"於梨華": "於梨华",
"於清言": "於清言",
"於潛": "於潜",
"於琳": "於琳",
"於穆": "於穆",
"於竹屋": "於竹屋",
"於菟": "於菟",
"於邑": "於邑",
"於陵子": "於陵子",
"旋乾轉坤": "旋乾转坤",
"旋轉乾坤": "旋转乾坤",
"旋轉乾坤之力": "旋转乾坤之力",
"明瞭": "明了",
"明覆": "明复",
"書中自有千鍾粟": "书中自有千锺粟",
"有序": "有序",
"朝乾夕惕": "朝乾夕惕",
"木吒": "木吒",
"李乾德": "李乾德",
"李澤鉅": "李泽钜",
"李鍊福": "李链福",
"李鍾郁": "李锺郁",
"樊於期": "樊於期",
"沈沒": "沉没",
"沈沒成本": "沉没成本",
"沈積": "沉积",
"沈船": "沉船",
"沈默": "沉默",
"流徵": "流徵",
"浪蕩乾坤": "浪荡乾坤",
"滑藉": "滑借",
"無序": "无序",
"牴牾": "抵牾",
"牴觸": "抵触",
"狐藉虎威": "狐借虎威",
"珍珠項鍊": "珍珠项链",
"甚鉅": "甚钜",
"申覆": "申复",
"畢昇": "毕昇",
"發覆": "发复",
"瞭如": "了如",
"瞭如指掌": "了如指掌",
"瞭望": "瞭望",
"瞭然": "了然",
"瞭然於心": "了然于心",
"瞭若指掌": "了若指掌",
"瞭解": "了解",
"瞭解到": "了解到",
"示覆": "示复",
"神祇": "神祇",
"稟覆": "禀复",
"竺乾": "竺乾",
"答覆": "答复",
"篤麼": "笃麽",
"簡單明瞭": "简单明了",
"籌畫": "筹划",
"素藉": "素借",
"老態龍鍾": "老态龙钟",
"肘手鍊足": "肘手链足",
"茵藉": "茵借",
"萬鍾": "万锺",
"蒜薹": "蒜薹",
"蕓薹": "芸薹",
"蕩覆": "荡复",
"蕭乾": "萧乾",
"藉代": "借代",
"藉以": "借以",
"藉助": "借助",
"藉助於": "借助于",
"藉卉": "借卉",
"藉口": "借口",
"藉喻": "借喻",
"藉寇兵": "借寇兵",
"藉寇兵齎盜糧": "借寇兵赍盗粮",
"藉手": "借手",
"藉據": "借据",
"藉故": "借故",
"藉故推辭": "借故推辞",
"藉方": "借方",
"藉條": "借条",
"藉槁": "借槁",
"藉機": "借机",
"藉此": "借此",
"藉此機會": "借此机会",
"藉甚": "借甚",
"藉由": "借由",
"藉着": "借着",
"藉端": "借端",
"藉端生事": "借端生事",
"藉箸代籌": "借箸代筹",
"藉草枕塊": "借草枕块",
"藉藉": "藉藉",
"藉藉无名": "藉藉无名",
"藉詞": "借词",
"藉讀": "借读",
"藉資": "借资",
"衹得": "只得",
"衹見樹木": "只见树木",
"衹見樹木不見森林": "只见树木不见森林",
"袖裏乾坤": "袖里乾坤",
"覆上": "复上",
"覆住": "复住",
"覆信": "复信",
"覆冒": "复冒",
"覆呈": "复呈",
"覆命": "复命",
"覆墓": "复墓",
"覆宗": "复宗",
"覆帳": "复帐",
"覆幬": "复帱",
"覆成": "复成",
"覆按": "复按",
"覆文": "复文",
"覆杯": "复杯",
"覆校": "复校",
"覆瓿": "复瓿",
"覆盂": "复盂",
"覆盆": "覆盆",
"覆盆子": "覆盆子",
"覆盤": "覆盘",
"覆育": "复育",
"覆蕉尋鹿": "复蕉寻鹿",
"覆逆": "复逆",
"覆醢": "复醢",
"覆醬瓿": "复酱瓿",
"覆電": "复电",
"覆露": "复露",
"覆鹿尋蕉": "复鹿寻蕉",
"覆鹿遺蕉": "复鹿遗蕉",
"覆鼎": "复鼎",
"見覆": "见复",
"角徵": "角徵",
"角徵羽": "角徵羽",
"計畫": "计划",
"變徵": "变徵",
"變徵之聲": "变徵之声",
"變徵之音": "变徵之音",
"貂覆額": "貂复额",
"買臣覆水": "买臣复水",
"踅門瞭戶": "踅门了户",
"躪藉": "躏借",
"郭子乾": "郭子乾",
"酒逢知己千鍾少": "酒逢知己千锺少",
"酒逢知己千鍾少話不投機半句多": "酒逢知己千锺少话不投机半句多",
"醞藉": "酝借",
"重覆": "重复",
"金吒": "金吒",
"金鍊": "金链",
"鈞覆": "钧复",
"鉅子": "钜子",
"鉅萬": "钜万",
"鉅防": "钜防",
"鉸鍊": "铰链",
"銀鍊": "银链",
"錢鍾書": "钱锺书",
"鍊墜": "链坠",
"鍊子": "链子",
"鍊形": "链形",
"鍊條": "链条",
"鍊錘": "链锤",
"鍊鎖": "链锁",
"鍛鍾": "锻锺",
"鍾繇": "钟繇",
"鍾萬梅": "锺万梅",
"鍾重發": "锺重发",
"鍾鍛": "锺锻",
"鍾馗": "锺馗",
"鎖鍊": "锁链",
"鐵鍊": "铁链",
"鑽石項鍊": "钻石项链",
"雁杳魚沈": "雁杳鱼沉",
"雖覆能復": "虽覆能复",
"電覆": "电复",
"露覆": "露复",
"項鍊": "项链",
"頗覆": "颇复",
"頸鍊": "颈链",
"顛乾倒坤": "颠乾倒坤",
"顛倒乾坤": "颠倒乾坤",
"顧藉": "顾借",
"麼些族": "麽些族",
"黄鍾公": "黄锺公",
"龍鍾": "龙钟",
"甚麼": "什么"
]
}
