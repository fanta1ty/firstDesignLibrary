//  Created by Thinh Nguyen
//

import SwiftUI

public struct BasicListRowView<L: View, C: View, T: View>: View {
    @ViewBuilder let leadingContent: L
    @ViewBuilder let centerContent: C
    @ViewBuilder let trailingContent: T

    let spacing: CGFloat

    public init(
        spacing: CGFloat = 16,
        @ViewBuilder leadingContent: () -> L,
        @ViewBuilder centerContent: () -> C,
        @ViewBuilder trailingContent: () -> T
    ) {
        self.spacing = spacing

        self.leadingContent = leadingContent()
        self.centerContent = centerContent()
        self.trailingContent = trailingContent()
    }

    public var body: some View {
        HStack(spacing: spacing) {
            leadingContent
            centerContent
            trailingContent
        }
        .contentShape(Rectangle())
    }
}

struct BasicListRowView_Preview: PreviewProvider {
    static var previews: some View {
        BasicListRowView {
            Image(uiImage: .add)
                .padding(16)
        } centerContent: {
            RowItemContentView(
                title: Text("Title"),
                subtitle: Text("Subtitle"),
                desc: Text("Description"),
                link: Text("Hello Link")
            )
            .padding(.vertical)
        } trailingContent: {
            Image(uiImage: .remove)
                .padding(16)
        }
        .previewable()
    }
}
