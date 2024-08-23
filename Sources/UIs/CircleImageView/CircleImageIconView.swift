//  Created by Thinh Nguyen
//

import SwiftUI

// MARK: - CircleImageIconView

public struct CircleImageIconView: View {
    let fillColor: Color
    let diameter: CGFloat
    let iconColor: Color
    let icon: UIImage
    let iconSize: CGFloat

    public init(
        fillColor: Color,
        diameter: CGFloat,
        iconColor: Color,
        icon: UIImage,
        iconSize: CGFloat
    ) {
        self.fillColor = fillColor
        self.diameter = diameter
        self.iconColor = iconColor
        self.icon = icon
        self.iconSize = iconSize
    }

    public var body: some View {
        ZStack {
            Circle()
                .frame(width: diameter, height: diameter)
                .foregroundColor(fillColor)
            Image(uiImage: icon)
                .resizable()
                .renderingMode(.template)
                .frame(width: iconSize, height: iconSize, alignment: .center)
                .foregroundColor(iconColor)
        }
    }
}

// MARK: - CircleImageIconView_Preview

struct CircleImageIconView_Preview: PreviewProvider {
    static var previews: some View {
        CircleImageIconView(
            fillColor: .brown,
            diameter: 60,
            iconColor: .red,
            icon: UIImage(systemName: "heart.fill")!,
            iconSize: 30
        )
    }
}
