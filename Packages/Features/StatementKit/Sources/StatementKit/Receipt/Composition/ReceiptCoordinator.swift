import UIKit

protocol ReceiptCoordinatorProtocol { 
    func showErrorAlert(with message: String, retryAction: @escaping () -> Void)
    func share(view: UIView)
}

final class ReceiptCoordinator: ReceiptCoordinatorProtocol {
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
