import UIKit

protocol StatementCoordinatorProtocol { }

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
}
