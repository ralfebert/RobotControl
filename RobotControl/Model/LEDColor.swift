// © 2019 Ralf Ebert — iOS Example Project: RobotControl
// License: https://opensource.org/licenses/MIT

import Foundation
import UIKit // TODO: remove

struct LEDColor: Codable {

    let red: UInt8
    let green: UInt8
    let blue: UInt8

    func toUIColor() -> UIColor {
        func convert(_ value: UInt8) -> CGFloat {
            CGFloat(value) / 255
        }

        return UIColor(red: convert(self.red), green: convert(self.green), blue: convert(self.blue), alpha: 1.0)
    }

}
