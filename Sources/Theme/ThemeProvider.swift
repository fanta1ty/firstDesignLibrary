//  Created by Thinh Nguyen
//

import Foundation

public class ThemeProvider: ObservableObject {
    @Published public var currentTheme: any TTheme

    public init(currentTheme: any TTheme) {
        self.currentTheme = currentTheme
    }
}
