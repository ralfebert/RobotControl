// © 2019 Ralf Ebert — iOS Example Project: RobotControl
// License: https://opensource.org/licenses/MIT

import Foundation

public struct LEDColor: Codable {

    public let red: UInt8
    public let green: UInt8
    public let blue: UInt8

    public init(red: UInt8, green: UInt8, blue: UInt8) {
        self.red = red
        self.green = green
        self.blue = blue
    }

}
