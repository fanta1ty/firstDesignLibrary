//  Created by Thinh Nguyen
//

import SwiftUI

// MARK: - CardTileView

public struct CardTileView: View {
    @EnvironmentObject var themeProvider: ThemeProvider
    let title: String
    let icon: UIImage

    init(
        title: String,
        icon: UIImage
    ) {
        self.title = title
        self.icon = icon
    }

    public var body: some View {
        HStack {
            Text(title)
                .font(themeProvider.currentTheme.fonts.body2Strong)
                .foregroundColor(themeProvider.currentTheme.colors.textPrimaryLight)
            Spacer()
            Image(uiImage: icon)
                .foregroundColor(themeProvider.currentTheme.colors.iconActive)
        }
        .padding(20)
    }
}

// MARK: - CardTileView_Preview

struct CardTileView_Preview: PreviewProvider {
    static var previews: some View {
        CardTileView(
            title: "View Card",
            icon: UIImage(systemName: "square.fill")!
        )
        .previewable()
    }
}
