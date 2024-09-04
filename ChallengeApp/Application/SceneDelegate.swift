import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    private let appStarter = AppStarter.shared

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()

        appStarter.start(window: window)
    }
}
