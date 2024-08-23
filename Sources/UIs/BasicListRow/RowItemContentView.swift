//  Created by Thinh Nguyen
//

import SwiftUI

public struct RowItemContentView<T: View, S: View, D: View, L: View>: View {
    @EnvironmentObject var themeProvider: ThemeProvider

    public let titleText: T?
    public let subtitleText: S?
    public let descText: D?
    public let linkText: L?

    public let spacing: CGFloat?

    public init(
        title: T? = emptyViewNil,
        subtitle: S? = emptyViewNil,
        desc: D? = emptyViewNil,
        link: L? = emptyViewNil,
        spacing: CGFloat? = nil
    ) {
        titleText = title
        subtitleText = subtitle
        descText = desc
        linkText = link

        self.spacing = spacing
    }

    public var body: some View {
        VStack(spacing: spacing, content: {
            titleText?.config(
                for: .title,
                in: themeProvider.currentTheme
            )

            subtitleText?.config(
                for: .subtitle,
                in: themeProvider.currentTheme
            )

            descText?.config(
                for: .desc,
                in: themeProvider.currentTheme
            )

            linkText?.config(
                for: .link,
                in: themeProvider.currentTheme
            )
        })
    }
}

struct RowItemContentView_Preview: PreviewProvider {
    static var previews: some View {
        RowItemContentView(
            title: Text("Title"),
            subtitle: Text("Subtitle"),
            desc: Text("Description"),
            link: Text("Link"),
            spacing: 20
        )
        .environmentObject(ThemeProvider(currentTheme: TThemeStandard()))
    }
}
