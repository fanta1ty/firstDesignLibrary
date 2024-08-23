//  Created by Thinh Nguyen
//

import SwiftUI

public struct TextButton<Content: View>: View {
    @EnvironmentObject var themeProvider: ThemeProvider
    @ViewBuilder let content: () -> Content

    let enabled: Bool
    let action: () -> Void

    init(
        enabled: Bool = true,
        action: @escaping () -> Void,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.content = content
        self.enabled = enabled
        self.action = action
    }

    public var body: some View {
        BaseButton(
            buttonStyle: TButtonDefault.TextButtonStyle(
                isEnabled: enabled,
                theme: themeProvider.currentTheme
            ),
            buttonSize: TButtonDefault.regularButtonSize(theme: themeProvider.currentTheme),
            enabled: enabled,
            action: action,
            content: content
        )
    }
}

struct TextButton_Previews: PreviewProvider {
    static var previews: some View {
        TextButton(
            action: {},
            content: {
                Text("Text Button")
            }
        ).previewable()
    }
}
