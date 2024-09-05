import UIKit
import RouterKit

protocol PasswordCoordinatorProtocol {
    func openStatement()
}

final class PasswordCoordinator: PasswordCoordinatorProtocol {
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
        navigation?.pushViewController(viewController, animated: true)
    }

    func openStatement() {
        if let url = URL(string: RouterURLs.statement) {
            router.start(url: url, on: navigation)
        }
    }
}
