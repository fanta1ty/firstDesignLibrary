//  Created by Thinh Nguyen
//

import SwiftUI

// MARK: - SegmentControlView

public struct SegmentControlView: View {
    @EnvironmentObject var themeProvider: ThemeProvider
    @Binding public var preselectedIndex: Int

    public var segments: [String]

    public init(
        preselectedIndex: Binding<Int>,
        segments: [String]
    ) {
        _preselectedIndex = preselectedIndex
        self.segments = segments
    }

    public var body: some View {
        HStack(spacing: 10, content: {
            ForEach(segments.indices, id: \.self) { index in
                VStack {
                    Text(segments[index])
                        .foregroundStyle(preselectedIndex == index ? themeProvider.currentTheme.colors.textPrimary : themeProvider.currentTheme.colors.textSecondary)
                        .font(themeProvider.currentTheme.fonts.body3)
                        .padding(12)
                        .overlay {
                            RoundedRectangle(cornerRadius: 40)
                                .stroke(preselectedIndex == index ? themeProvider.currentTheme.colors.uiAccent : themeProvider.currentTheme.colors.borderDisabled, lineWidth: 1)
                        }
                }
                .onTapGesture {
                    withAnimation(.interactiveSpring()) {
                        preselectedIndex = index
                    }
                }
                .fixedSize()
                .cornerRadius(40)
            }
            Spacer()
        })
    }
}

// MARK: - SegmentControlView_Preview

struct SegmentControlView_Preview: PreviewProvider {
    static var previews: some View {
        VStack {
            SegmentControlView(
                preselectedIndex: .constant(10),
                segments: [
                    "Test 1",
                    "Test 2",
                    "Test 3",
                ]
            )
        }
        .previewable()
    }
}
