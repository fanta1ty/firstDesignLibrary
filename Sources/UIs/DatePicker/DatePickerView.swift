//  Created by Thinh Nguyen
//

import SwiftUI

// MARK: - DatePickerView

public struct DatePickerView: View {
  @State private var selectedDate = Date()
  @State private var endDateAddition: Int = 0

  let title: String

  public init(title: String) {
    self.title = title
  }

  public var body: some View {
    VStack {
      DatePicker(
        title,
        selection: $selectedDate,
        displayedComponents: [.date]
      )
      .datePickerStyle(.graphical)
      .padding()
    }
  }
}

// MARK: - DatePickerView_Preview

struct DatePickerView_Preview: PreviewProvider {
  static var previews: some View {
    DatePickerView(title: "Select a date")
      .overlay(
        RoundedRectangle(
          cornerRadius: 8
        )
        .stroke(.black, lineWidth: 1))
      .padding()

  }
}
