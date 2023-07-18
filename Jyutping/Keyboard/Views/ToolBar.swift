import SwiftUI

struct ToolBar: View {

        @EnvironmentObject private var context: KeyboardViewController

        private let itemWidth: CGFloat = 50

        var body: some View {
                HStack(spacing: 0) {
                        ToolBarItem(imageName: "gear", width: itemWidth, height: Constant.toolBarHeight, insets: EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
                                .contentShape(Rectangle())
                                .onTapGesture {
                                        AudioFeedback.modified()
                                        context.triggerHapticFeedback()
                                        context.updateKeyboardForm(to: .settings)
                                }

                        Spacer()
                        ZStack {
                                Color.interactiveClear
                                Image(uiImage: UIImage.emojiSmiley)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24, height: 24)
                        }
                        .frame(width: itemWidth, height: Constant.toolBarHeight)
                        .contentShape(Rectangle())
                        .onTapGesture {
                                AudioFeedback.modified()
                                context.triggerHapticFeedback()
                                context.updateKeyboardForm(to: .emojiBoard)
                        }

                        Spacer()
                        ZStack {
                                Color.interactiveClear
                                CantoneseABCSwitch(isCantoneseSelected: context.inputMethodMode.isCantonese)
                        }
                        .frame(width: 80, height: Constant.toolBarHeight)
                        .contentShape(Rectangle())
                        .onTapGesture {
                                AudioFeedback.modified()
                                context.triggerSelectionHapticFeedback()
                                context.toggleInputMethodMode()
                        }

                        Spacer()
                        ToolBarItem(imageName: "arrow.left.and.line.vertical.and.arrow.right", width: itemWidth, height: Constant.toolBarHeight, insets: EdgeInsets(top: 22, leading: 0, bottom: 22, trailing: 0))
                                .onTapGesture {
                                        AudioFeedback.modified()
                                        context.triggerHapticFeedback()
                                        context.updateKeyboardForm(to: .editingPanel)
                                }

                        Spacer()
                        ToolBarItem(imageName: "keyboard.chevron.compact.down", width: itemWidth, height: Constant.toolBarHeight, insets: EdgeInsets(top: 21, leading: 0, bottom: 22, trailing: 0))
                                .onTapGesture {
                                        AudioFeedback.modified()
                                        context.triggerHapticFeedback()
                                        context.dismissKeyboard()
                                }
                }
        }
}
