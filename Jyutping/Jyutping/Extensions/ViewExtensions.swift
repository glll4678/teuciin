import SwiftUI

extension View {

        @available(iOS, unavailable)
        func block() -> some View {
                #if os(macOS)
                return self.padding().background(Color.textBackgroundColor, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
                #else
                return self
                #endif
        }
}

