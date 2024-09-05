import UIKit
import RouterKit

protocol PasswordCoordinatorProtocol {
    func openStatement()
    func showErrorAlert(with message: String, retryAction: @escaping () -> Void)
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

    func showErrorAlert(with message: String, retryAction: @escaping () -> Void) {
        let alert = UIAlertController(
            title: Strings.errorGenericTitle,
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(
            title: Strings.tryAgainButton,
            style: .default
        ) { _ in
            retryAction()
        })
        alert.addAction(UIAlertAction(
            title: Strings.closeButton,
            style: .cancel
        ))

        navigation?.present(alert, animated: true, completion: nil)
    }
}
