//  Created by Thinh Nguyen
//

import SwiftUI

// MARK: - FormButton

public struct FormButton<Content: View>: View {
    @EnvironmentObject var themeProvider: ThemeProvider
    @ViewBuilder let content: () -> Content
    @Environment(\.safeAreaInsets) private var safeAreaInsets

    let enabled: Bool
    let action: () -> Void

    public init(
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
            buttonStyle: TButtonDefault.FormButtonStyle(
                isEnabled: enabled,
                theme: themeProvider.currentTheme
            ),
            buttonSize: TButtonDefault.formButtonSize(
                theme: themeProvider.currentTheme
            ),
            enabled: enabled,
            action: action,
            content: content
        )
        .overlay(alignment: .bottom) {
            if safeAreaInsets.bottom > 0 {
                Color.clear
                    .contentShape(Rectangle())
                    .frame(height: safeAreaInsets.bottom)
                    .padding(.bottom, -safeAreaInsets.bottom)
                    .allowsHitTesting(true)
            }
        }
    }
}

// MARK: - FormButton_Preview

struct FormButton_Preview: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            FormButton(action: {}, content: {
                Text("Let's Go")
                    .frame(maxWidth: .infinity)
            })
        }
        .previewable()
    }
}
