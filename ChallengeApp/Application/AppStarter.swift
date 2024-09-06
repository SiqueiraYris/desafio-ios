import UIKit
import RouterKit
import StatementKit

final class AppStarter {
    private let navigation = UINavigationController()
    private let routingHub = RoutingHub.shared
    static var shared = AppStarter()

    func start(window: UIWindow?) {
        setupRoutingHub(window: window)
    }
    
    private func setupRoutingHub(window: UIWindow?) {
        let descriptorsManager = DescriptorsManager(routingHub: routingHub)
        descriptorsManager.setup()

        window?.rootViewController = navigation

        if let url = URL(string: RouterURLs.launcher) {
            routingHub.start(url: url, on: navigation)
        }
    }
}
