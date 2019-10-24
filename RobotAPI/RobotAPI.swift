// © 2019 Ralf Ebert — iOS Example Project: RobotControl
// License: https://opensource.org/licenses/MIT

import Foundation

public class RobotAPI {

    private let urlSession = URLSession.shared
    private let jsonDecoder = JSONDecoder()
    private let jsonEncoder = JSONEncoder()

    private let url = URL(string: "https://schulungsroboter.ngrok.io/color")!

    public init() {}

    public var notificationQueue = DispatchQueue.main

    public func getColor(completionHandler: @escaping (LEDColor) -> Void) {

        let task = self.urlSession.dataTask(with: self.url) { data, _, error in
            guard let data = data, error == nil else {
                debugPrint("Fehler beim Setzen", error ?? "Unbekannter Fehler")
                return
            }

            let color = try! self.jsonDecoder.decode(LEDColor.self, from: data)

            self.notificationQueue.async {
                completionHandler(color)
            }
        }

        task.resume()
    }

    public func setColor(color: LEDColor, completionHandler: (() -> Void)? = nil) {
        var request = URLRequest(url: self.url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = ["Content-Type": "application/json"]
        request.httpBody = try! self.jsonEncoder.encode(color)

        let task = self.urlSession.dataTask(with: request) { data, _, error in
            guard data != nil, error == nil else {
                debugPrint("Fehler beim Laden", error ?? "Unbekannter Fehler")
                return
            }

            self.notificationQueue.async {
                completionHandler?()
            }
        }
        task.resume()
    }

}
