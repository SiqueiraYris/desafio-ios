import UIKit

protocol StatementCoordinatorProtocol {
    func openDetails(id: String)
    func showErrorAlert(with message: String, retryAction: @escaping () -> Void)
}

final class StatementCoordinator: StatementCoordinatorProtocol {
    // MARK: - Properties

    private weak var navigation: UINavigationController?

    // MARK: - initializer

    init(navigation: UINavigationController?) {
        self.navigation = navigation
    }

    // MARK: - Methods

    func start(viewController: UIViewController) {
        navigation?.pushViewController(viewController, animated: true)
    }

    func openDetails(id: String) {
        ReceiptComposer.startScene(navigation, id: id)
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
