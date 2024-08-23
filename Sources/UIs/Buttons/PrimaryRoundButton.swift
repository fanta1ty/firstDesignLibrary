//  Created by Thinh Nguyen
//

import SwiftUI

public struct PrimaryRoundButton<Content: View>: View {
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
            buttonStyle: TButtonDefault.PrimaryRoundButtonStyle(
                isEnabled: enabled,
                theme: themeProvider.currentTheme
            ),
            buttonSize: TButtonDefault.primaryRoundButtonSize(theme: themeProvider.currentTheme),
            enabled: enabled,
            action: action,
            content: content
        )
    }
}

struct PrimaryRoundButton_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryRoundButton(
            action: {},
            content: {
                Text("Primary Round Button")
            }
        ).previewable()
    }
}
