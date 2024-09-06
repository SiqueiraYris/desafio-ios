import UIKit

protocol StatementCoordinatorProtocol {
    func openDetails(id: String, type: String)
    func showErrorAlert(with message: String, retryAction: @escaping () -> Void)
    func share(view: UIView)
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

    func openDetails(id: String, type: String) {
        ReceiptComposer.startScene(navigation, id: id, type: type)
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

    func share(view: UIView) {
        let image = view.asImage()
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)

        if let popoverController = activityViewController.popoverPresentationController {
            popoverController.sourceView = view
            popoverController.sourceRect = view.bounds
        }

        navigation?.present(activityViewController, animated: true, completion: nil)
    }
}
