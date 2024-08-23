//  Created by Thinh Nguyen
//

import SwiftUI

// MARK: - Carousel

struct Carousel<Content: View>: View {
    @EnvironmentObject var themeProvider: ThemeProvider
    @ViewBuilder let content: Content
    @State private var index = 0

    let maxIndent: Int

    public init(
        maxIndent: Int,
        @ViewBuilder content: () -> Content
    ) {
        self.content = content()
        self.maxIndent = maxIndent
    }

    var body: some View {
        VStack {
            TabView(selection: $index,
                    content: {
                        ForEach(0 ..< maxIndent, id: \.self) { _ in
                            content
                        }
                    })
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                    .onChange(of: index) { newValue in
                        if newValue == maxIndent {
                            index = 0
                        }
                    }
        }
        .frame(height: 200)
    }
}

// MARK: - Carousel_Preview

struct Carousel_Preview: PreviewProvider {
    static var previews: some View {
        Carousel(maxIndent: 3) {
            HStack {
                CardView(fillColor: .blue) {
                    VStack {
                        Text("Hello Title")
                            .frame(
                                maxWidth: .infinity,
                                alignment: .leading
                            )
                        Spacer()
                        Text("Hello Subtitle")
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
        }.previewable()
    }
}
