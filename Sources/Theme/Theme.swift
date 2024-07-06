//  Created by Thinh Nguyen
//

import Foundation

public protocol TTheme: Identifiable {
  var id: ThemeType { get }
  var fonts: TTypography { get set }
  var colors: TColorsPalatte { get set }
}
