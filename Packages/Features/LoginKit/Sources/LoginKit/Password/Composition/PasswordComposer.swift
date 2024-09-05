import UIKit
import NetworkKit

struct PasswordComposer {
    static func startScene(_ navigation: UINavigationController) {
        // instantiate the dependencies and call coordinator
        let networkManager = NetworkManager.shared
        let coordinator = PasswordCoordinator(navigation: navigation)
        let service = PasswordService(networkManager)
        let viewModel = PasswordViewModel(coordinator: coordinator, service: service)
        let viewController = PasswordViewController(with: viewModel)

        coordinator.start(viewController: viewController)
    }
}
