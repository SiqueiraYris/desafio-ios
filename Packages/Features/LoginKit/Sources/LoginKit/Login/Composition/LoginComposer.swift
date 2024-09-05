import UIKit

public struct LoginComposer {
    public static func startScene(_ navigation: UINavigationController?) {
        let coordinator = LoginCoordinator(navigation: navigation)
        let viewModel = LoginViewModel(coordinator: coordinator)
        let viewController = LoginViewController(with: viewModel)

        coordinator.start(viewController: viewController)
    }
}
