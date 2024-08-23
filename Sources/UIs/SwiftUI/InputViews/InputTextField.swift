//  Created by Thinh Nguyen
//

import SwiftUI

public let emptyContent = { EmptyView() }

// MARK: - InputTextField

public struct InputTextField<L: View, T: View>: View {
    @FocusState private var isForcused: Bool
    @State private var isAnimatedFocused: Bool = false
    @EnvironmentObject var themeProvider: ThemeProvider

    @Binding var text: String
    let label: String
    @ViewBuilder let leadingContent: L
    @ViewBuilder let trailingContent: T

    let helperText: String
    let isEnabled: Bool
    let iSError: Bool
    let isDividerHidden: Bool
    let autoFocus: Bool

    public init(
        text: Binding<String>,
        label: String,
        helperText: String = "",
        isEnabled: Bool = true,
        isError: Bool = false,
        autoFocus: Bool = false,
        isDividerHidden: Bool = false,
        @ViewBuilder leadingContent: () -> L = emptyContent,
        @ViewBuilder trailingContent: () -> T = emptyContent
    ) {
        _text = text
        self.label = label
        self.helperText = helperText
        self.isEnabled = isEnabled
        iSError = isError
        self.isDividerHidden = isDividerHidden
        self.leadingContent = leadingContent()
        self.trailingContent = trailingContent()
        self.autoFocus = autoFocus
    }

    public var body: some View {
        VStack(alignment: .leading, content: {
            VStack(spacing: 16, content: {
                Color.clear
                    .frame(height: 8)

                HStack(spacing: 8, content: {
                    leadingContent

                    ZStack(alignment: .bottomLeading, content: {
                        TextField(text: $text, label: {})
                            .autocorrectionDisabled()
                            .font(themeProvider.currentTheme.fonts.body2)
                            .foregroundStyle(isEnabled ? themeProvider.currentTheme.colors.textPrimary : themeProvider.currentTheme.colors.textDisabled)
                            .focused($isForcused)
                            .disabled(!isEnabled)

                        let isLabelUp = isAnimatedFocused || !text.isEmpty
                        Text(label)
                            .font(isLabelUp ? themeProvider.currentTheme.fonts.label2 : themeProvider.currentTheme.fonts.body2)
                            .foregroundStyle(isEnabled ? themeProvider.currentTheme.colors.textTertiary : themeProvider.currentTheme.colors.textDisabled)
                            .padding(.bottom, isLabelUp ? 24 : 0)

                    })
                    .frame(height: 40)

                    trailingContent
                })
                CustomDivider(color: dividerColor())
            })
            .contentShape(Rectangle())
            .onTapGesture {
                isForcused = true
            }

            if !helperText.isEmpty {
                Text(helperText)
                    .font(themeProvider.currentTheme.fonts.body3)
                    .foregroundStyle(iSError ? themeProvider.currentTheme.colors.textNegative : themeProvider.currentTheme.colors.textTertiary)
            }
        })
        .onChange(of: isForcused) { new in
            withAnimation {
                isAnimatedFocused = new
            }
        }
        .onAppear(perform: {
            if autoFocus {
                isForcused = true
            }
        })
    }

    private func dividerColor() -> Color {
        if isDividerHidden {
            return .clear
        }
        if iSError {
            return themeProvider.currentTheme.colors.borderNegative
        }
        if isForcused {
            return themeProvider.currentTheme.colors.borderFocus
        }

        return isEnabled ? themeProvider.currentTheme.colors.border : .clear
    }
}

// MARK: - InputTextField_Preview

struct InputTextField_Preview: PreviewProvider {
    static var previews: some View {
        VStack {
            InputTextField(
                text: .constant("Text"),
                label: "Test 1",
                helperText: "Helper Text"
            )

            InputTextField(
                text: .constant("Text 2"),
                label: "Test 2",
                leadingContent: {
                    Image(uiImage: .checkmark)
                },
                trailingContent: {
                    Image(uiImage: .add)
                }
            )

            InputTextField(
                text: .constant("Text 3"),
                label: "Test 3",
                helperText: "Helper Text",
                isError: true
            )

            InputTextField(
                text: .constant("Text 4"),
                label: "Test 4",
                isDividerHidden: true
            )

            InputTextField(
                text: .constant("Text 5"),
                label: "Test 5",
                isEnabled: false
            )

            Spacer()
        }
        .padding()
        .previewable()
    }
}
