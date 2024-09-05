//  Created by Thinh Nguyen
//

import Foundation

public protocol InputViewDelegate: AnyObject {
    func input(viewDidSelectEndButton input: InputView)
    func input(view: InputView, textDidChange text: String)
    func input(viewDidEndEditting input: InputView)
}

public extension InputViewDelegate {
    func input(viewDidSelectEndButton _: InputView) {}
    func input(view _: InputView, textDidChange _: String) {}
    func input(viewDidEndEditting _: InputView) {}
}
