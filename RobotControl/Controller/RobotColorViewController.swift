// © 2019 Ralf Ebert — iOS Example Project: RobotControl
// License: https://opensource.org/licenses/MIT

import UIKit

class RobotColorViewController: UIViewController {

    // MARK: - State

    var color = LEDColor(red: 255, green: 255, blue: 255) {
        didSet {
            self.updateView()
        }
    }

    // MARK: - Outlets

    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!

    // MARK: - Dependencies

    let robotAPI = RobotAPI()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.refresh()
        self.updateView()
    }

    func updateView() {
        self.redSlider.value = Float(self.color.red)
        self.greenSlider.value = Float(self.color.green)
        self.blueSlider.value = Float(self.color.blue)
        self.view.backgroundColor = self.color.toUIColor()
    }

    // MARK: - Actions

    func sendColor() {
        self.robotAPI.setColor(color: self.color)
    }

    @IBAction func refresh() {
        self.robotAPI.getColor { color in
            self.color = color
        }
    }

    @IBAction func redTapped() {
        self.color = LEDColor(red: 255, green: 0, blue: 0)
        self.sendColor()
    }

    @IBAction func greenTapped() {
        self.color = LEDColor(red: 0, green: 255, blue: 0)
        self.sendColor()
    }

    @IBAction func blueTapped() {
        self.color = LEDColor(red: 0, green: 0, blue: 255)
        self.sendColor()
    }

    @IBAction func sliderTouchUpInside() {
        self.sendColor()
    }

    @IBAction func sliderValueChanged(_: Any) {
        let red = UInt8(self.redSlider.value)
        let green = UInt8(self.greenSlider.value)
        let blue = UInt8(self.blueSlider.value)
        self.color = LEDColor(red: red, green: green, blue: blue)
    }

}
