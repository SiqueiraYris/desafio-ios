import UIKit
import RouterKit

protocol LauncherCoordinatorProtocol {
    func openLogin()
}

final class LauncherCoordinator: LauncherCoordinatorProtocol {
    // MARK: - Properties

    private weak var navigation: UINavigationController?
    private let router: RoutingHubProtocol

    // MARK: - initializer

    init(navigation: UINavigationController?, router: RoutingHubProtocol) {
        self.navigation = navigation
        self.router = router
    }

    // MARK: - Methods

    func start(viewController: UIViewController) {
        navigation?.isNavigationBarHidden = true
        navigation?.pushViewController(viewController, animated: true)
    }

    func openLogin() {
        if let url = URL(string: RouterURLs.login) {
            router.start(url: url, on: navigation)
        }
    }
}
