import SwiftUI

struct MotherBoard: View {

        @EnvironmentObject private var context: KeyboardViewController

        var body: some View {
                switch context.keyboardForm {
                case .settings:
                        if #available(iOSApplicationExtension 16.0, *) {
                                SettingsView().environmentObject(context)
                        } else {
                                SettingsViewIOS15().environmentObject(context)
                        }
                case .editingPanel:
                        EditingPanel().environmentObject(context)
                case .candidateBoard:
                        CandidateBoard().environmentObject(context)
                case .numeric, .symbolic:
                        NumericSymbolicKeyboard().environmentObject(context)
                default:
                        VStack(spacing: 0) {
                                if context.inputStage.isBuffering {
                                        CandidateScrollBar().environmentObject(context)
                                } else {
                                        ToolBar().environmentObject(context)
                                }
                                AlphabeticKeyboard().environmentObject(context)
                        }
                }
        }
}
