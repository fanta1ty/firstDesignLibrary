//  Created by Thinh Nguyen
//

import Combine
import SwiftUI

public struct InfiniteCarousel<Content: View, T: Any>: View {
  @EnvironmentObject var themeProvider: ThemeProvider

  @State private var timer: Timer.TimerPublisher
  @State private var cancellable: Cancellable?
  @State private var selectedTab: Int = 1
  @GestureState private var isDragging = false
  @State private var isEnded = false
  @State private var isManualSwipe = false

  private let data: [T]
  private let autoRotateFrequency: Double
  private let swipeTransitionDuration: Double
  private let content: (T) -> Content
  private let showAlternativeBanner: Bool
  private let height: CGFloat
  private let defaultPadding: CGFloat
  private let cornerRadius: CGFloat
  private let transition: TransitionType
  private let selectedStepperColor: Color?
  private let isPageControlCentered: Bool
  private let stepperColor: Color?

  var onSwipe: ((Int) -> Void)? = nil

  public init(
    data: [T],
    autoRotateFrequency: Double = 4,
    swipeTransitionDuration: Double = 0.4,
    height: CGFloat = 150,
    defaultPadding: CGFloat = 20,
    cornerRadius: CGFloat = 10,
    stepperColor: Color? = nil,
    transition: TransitionType = .scale,
    selectedStepperColor: Color? = nil,
    isPageControlCentered: Bool = false,
    @ViewBuilder content: @escaping (T) -> Content,
    onSwipe: @escaping (Int) -> Void
  ) {
    var modifiedData = data

    if data.count > 1, 
        let firstElement = data.first,
       let lastElement = data.last {
      modifiedData.append(firstElement)
      modifiedData.insert(lastElement, at: 0)
      showAlternativeBanner = false
    } else {
      showAlternativeBanner = true
    }

    _timer = .init(initialValue: Timer.publish(
      every: autoRotateFrequency,
      on: .main, in: .common
    ))

    self.data = modifiedData
    self.content = content
    self.autoRotateFrequency = autoRotateFrequency
    self.swipeTransitionDuration = swipeTransitionDuration
    self.height = height
    self.defaultPadding = defaultPadding
    self.cornerRadius = cornerRadius
    self.stepperColor = stepperColor
    self.transition = transition
    self.selectedStepperColor = selectedStepperColor
    self.isPageControlCentered = isPageControlCentered
    self.onSwipe = onSwipe
  }

  public var body: some View {
    let stepper: Color = stepperColor ?? themeProvider.currentTheme.colors.uiAccent

    TabView(selection: $selectedTab,
            content:  {
      ForEach(Array(zip(data.indices, data)), id: \.0) { index, item in
        GeometryReader(content: { _ in
          content(item)
            .padding([.horizontal, .top], defaultPadding)
            .padding(.bottom, data.count > 1 ? 32 : defaultPadding)
        })
        .tag(index)
      }
    })
    .tabViewStyle(.page(indexDisplayMode: .never))
    .if(data.count == 0) { _ in
      EmptyView()
    }
    .if(data.count > 1) {
      $0.overlay(
        HStack(spacing: 8, content: {
          ForEach(1..<data.count-1, id: \.self) { ind in
            Capsule()
              .cornerRadius(2)
              .foregroundColor(ind == selectedTab ? selectedStepperColor : stepper)
              .frame(width: ind == selectedTab ? 12 : 4, height: 4)
          }
        })
        .padding(.bottom, defaultPadding)
        .padding(.leading, isPageControlCentered ? 0 : 20),
        alignment: isPageControlCentered ? .bottom : .bottomLeading
      )
      .onChange(of: selectedTab) { newValue in
        if isManualSwipe {
          if newValue == 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + swipeTransitionDuration, execute: {
              selectedTab = data.count - 2
              onSwipe?(selectedTab - 1)
            })
          } else {
            if newValue == data.count - 1 {
              DispatchQueue.main.asyncAfter(deadline: .now() + swipeTransitionDuration, execute: {
                selectedTab = 1
                onSwipe?(selectedTab - 1)
              })
            } else {
              DispatchQueue.main.asyncAfter(deadline: .now() + swipeTransitionDuration, execute: {
                onSwipe?(selectedTab - 1)
              })
            }
          }
          isManualSwipe = false
        } else {
          if showAlternativeBanner {
            guard newValue < data.count else {
              withAnimation {
                selectedTab = 0
                onSwipe?(selectedTab)
              }
              return
            }
          } else {
            if newValue == 0 {
              DispatchQueue.main.asyncAfter(deadline: .now() + swipeTransitionDuration, execute: {
                selectedTab = data.count - 2
                onSwipe?(selectedTab)
              })
            }

            if newValue == data.count - 1 {
              DispatchQueue.main.asyncAfter(deadline: .now() + swipeTransitionDuration, execute: {
                selectedTab = 1
                onSwipe?(selectedTab)
              })
            }
          }
        }
      }
      .onReceive(timer, perform: { _ in
        withAnimation {
          onSwipe?(selectedTab)
            selectedTab += 1
        }
      })
      .gesture(DragGesture()
        .updating($isDragging, body: { _, state, _ in
          state = true
        })
          .onChanged({ _ in
            stopTimer()
            isManualSwipe = true
          })
      )
      .onChange(of: isDragging) { newIsActiveValue in
        if !newIsActiveValue {
          DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            startTimer()
          })
        }
      }
    }
    .onAppear {
      if data.count > 1 {
        startTimer()
      }
    }
  }
}

extension InfiniteCarousel {
  private func startTimer() {
    guard cancellable == nil else { return }

    timer = Timer.publish(every: autoRotateFrequency, on: .main, in: .common)
    cancellable = timer.connect()
  }

  private func stopTimer() {
    guard cancellable == nil else { return }
    cancellable?.cancel()
    cancellable = nil
  }
}

struct InfiniteCarousel_Preview: PreviewProvider {
  static var previews: some View {
    CardView(fillColor: .accentColor) {
      InfiniteCarousel(data: [
        "Item 1",
        "Item 2",
        "Item 3",
        "Item 4"
      ]) { element in
        Text(element)
          .font(.title.bold())
          .padding()
          .background(.blue)
      } onSwipe: { nextIndex in
        print("next index is: \(nextIndex)")
      }
    }
    .frame(width: .infinity, height: 200)
    .padding(20)
    .previewable()
  }
}
