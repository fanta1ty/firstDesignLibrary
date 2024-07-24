//  Created by Thinh Nguyen
//

import SwiftUI

struct ViewDidLoadModifier: ViewModifier {
  @State private var viewDidLoad = false

  let action: () -> Void

  func body(content: Content) -> some View {
    content
      .onAppear(perform: {
        if viewDidLoad == false {
          viewDidLoad = true
          action()
        }
      })
  }
}

struct ViewDidLoadModifier_Preview: PreviewProvider {
  static var previews: some View {
    VStack {
      Text("Test View Did Load Modifier")
        .onViewDidLoad {
          print("View Did Load")
        }
    }
    .previewable()
  }
}
