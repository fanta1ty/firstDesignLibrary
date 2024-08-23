//  Created by Thinh Nguyen
//

import SwiftUI

public struct AnimationModifier: ViewModifier {
    @ObservedObject var manager: OpacityAnimationManager

    let duration: CGFloat
    let delay: CGFloat

    public func body(content: Content) -> some View {
        content
            .opacity(manager.opacity)
            .onAppear {
                withAnimation(.easeIn(duration: duration).delay(delay)) {
                    manager.opacity = 1
                }
            }
    }
}

struct AnimationModifier_Preview: PreviewProvider {
    static var previews: some View {
        Text("Test Animation Modifier")
            .addOpacityAnimation(opacityManager: .init(opacity: 0))
    }
}
