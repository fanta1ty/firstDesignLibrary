//  Created by Thinh Nguyen
//

import Foundation
import UIKit

public extension UIApplication {
  var windowScene: UIWindowScene? {
    connectedScenes
      .first { ($0 is UIWindowScene) } as? UIWindowScene
  }

  var sceneWindows: [UIWindow] {
    guard let windowScene else { return [] }
    return windowScene.windows
  }

  var sceneKeyWindow: UIWindow? {
    sceneWindows
      .first { $0.isKeyWindow }
  }
}
