//  Created by Thinh Nguyen
//

import Foundation
import UIKit

public protocol BottomSheetChild: UIViewController {
    var delegate: BottomSheetChildDelegate? { get set }
}
