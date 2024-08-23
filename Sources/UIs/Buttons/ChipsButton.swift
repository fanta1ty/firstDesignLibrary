//  Created by Thinh Nguyen
//

import SwiftUI

// MARK: - ChipsButton

public struct ChipsButton<Content: View>: View {
    @EnvironmentObject var themeProvider: ThemeProvider
    @ViewBuilder let content: () -> Content

    let enabled: Bool
    let selected: Bool
    let action: () -> Void

    public init(
        enabled: Bool = true,
        selected: Bool,
        action: @escaping () -> Void,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.content = content
        self.enabled = enabled
        self.selected = selected
        self.action = action
    }

    public var body: some View {
        BaseButton(
            buttonStyle: TButtonDefault.ChipsButtonStyle(
                isEnabled: enabled,
                isSelected: selected,
                theme: themeProvider.currentTheme
            ),
            buttonSize: TButtonDefault.chipsButtonSize(
                theme: themeProvider.currentTheme
            ),
            enabled: enabled,
            action: action,
            content: content
        )
    }
}

// MARK: - ChipsButton_Preview

struct ChipsButton_Preview: PreviewProvider {
    static var previews: some View {
        ChipsButton(
            selected: false,
            action: {}
        ) {
            Text("ChipsButton")
        }
        .previewable()
    }
}
