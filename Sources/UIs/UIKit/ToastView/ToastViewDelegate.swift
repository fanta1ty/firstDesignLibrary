//  Created by Thinh Nguyen
//

import Foundation
import UIKit

public protocol ToastViewDelegate: AnyObject {
    func toast(view: ToastView, didSelectClose: UIButton)
    func toast(view: ToastView, didSelectLink: UIButton)
}

public extension ToastViewDelegate {
    func toast(view _: ToastView, didSelectClose _: UIButton) {}
    func toast(view _: ToastView, didSelectLink _: UIButton) {}
}
