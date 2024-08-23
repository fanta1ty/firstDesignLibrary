//  Created by Thinh Nguyen
//

import SwiftUI

// MARK: - CardView

public struct CardView<Content: View>: View {
    @EnvironmentObject var themeProvider: ThemeProvider
    @ViewBuilder let content: () -> Content
    @State var cardState: CardState = .loading

    let fillColor: Color

    init(
        fillColor: Color,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.fillColor = fillColor
        self.content = content
    }

    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(fillColor)
            content()
        }
    }
}

// MARK: - CardView_Preview

struct CardView_Preview: PreviewProvider {
    static var previews: some View {
        CardView(fillColor: .gray) {
            VStack {
                Text("Title")
                    .redacted(reason: .placeholder)
                Text("Subtitle")
                    .redacted(reason: .placeholder)
                PrimaryButton(action: {}) {
                    Text("Title")
                }
            }
        }
        .fixedSize()
        .previewable()
    }
}
