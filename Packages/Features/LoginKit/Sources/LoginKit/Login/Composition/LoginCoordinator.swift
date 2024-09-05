import UIKit

protocol LoginCoordinatorProtocol {
    func openPassword(document: String)
}

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

    func openPassword(document: String) {
        PasswordComposer.startScene(navigation, document: document)
    }
}
