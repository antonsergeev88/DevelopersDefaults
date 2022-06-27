import DeveloperDefaults
import DeveloperDefaultsRuntime
import SwiftUI
import UIKit

public class DeveloperDefaultsController {
    private static var settingsWindow: UIWindow?

    public static func show() {
        guard self.settingsWindow == nil else { return }

        let activeScene = UIApplication.shared
            .connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first { $0.activationState == .foregroundActive }
        guard let windowScene = activeScene else { return }
        let window = UIWindow(windowScene: windowScene)
        window.backgroundColor = .black
        window.alpha = 0
        self.settingsWindow = window
        CloseToolbarButton.closeHandler = {
            UIView.animate(withDuration: 0.2) {
                self.settingsWindow?.alpha = 0
            } completion: { _ in
                self.settingsWindow = nil
            }
        }
        window.rootViewController = UIHostingController(rootView: RootSettingsView())
        window.makeKeyAndVisible()
        UIView.animate(withDuration: 0.2) {
            self.settingsWindow?.alpha = 1
        }
    }
}
