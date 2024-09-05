import UIKit
import NetworkKit

struct PasswordComposer {
    static func startScene(_ navigation: UINavigationController?, document: String) {
        let networkManager = NetworkManager.shared
        let coordinator = PasswordCoordinator(navigation: navigation)
        let service = PasswordService(networkManager)
        let viewModel = PasswordViewModel(coordinator: coordinator, service: service, document: document)
        let viewController = PasswordViewController(with: viewModel)

        coordinator.start(viewController: viewController)
    }
}
