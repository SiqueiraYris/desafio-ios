import UIKit

protocol LoginCoordinatorProtocol { }

final class LoginCoordinator: LoginCoordinatorProtocol {
    // MARK: - Properties

    private weak var navigation: UINavigationController?

    // MARK: - initializer

    init(navigation: UINavigationController?) {
        self.navigation = navigation
    }

    // MARK: - Methods

    func start(viewController: UIViewController) {
        navigation?.isNavigationBarHidden = false
        navigation?.pushViewController(viewController, animated: true)
    }
}
