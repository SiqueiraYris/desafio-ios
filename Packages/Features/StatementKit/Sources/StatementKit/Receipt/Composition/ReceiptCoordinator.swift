import UIKit

protocol ReceiptCoordinatorProtocol { }

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
}
