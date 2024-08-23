//  Created by Thinh Nguyen
//

import CoreMotion
import Foundation

public class MotionManager: ObservableObject {
    @Published var pitch: Double = 0.0
    @Published var roll: Double = 0.0

    private var manager: CMMotionManager

    public init() {
        manager = CMMotionManager()
        manager.deviceMotionUpdateInterval = 1 / 60
        manager.startDeviceMotionUpdates(to: .main) { motionData, error in
            guard error == nil else {
                print(error!)
                return
            }

            if let motionData {
                self.pitch = motionData.attitude.pitch
                self.roll = motionData.attitude.roll
            }
        }
    }
}
