//  Created by Thinh Nguyen
//

import SwiftUI

public struct PresentationBackgroundModifier: ViewModifier {
    let color: Color

    public func body(content: Content) -> some View {
        content.background(
            PresentationBackgroundView(color: UIColor(color))
        )
    }
}
