//  Created by Thinh Nguyen
//

import SwiftUI

public protocol ContainerView: View {
    associatedtype Content
    init(content: @escaping () -> Content)
}
