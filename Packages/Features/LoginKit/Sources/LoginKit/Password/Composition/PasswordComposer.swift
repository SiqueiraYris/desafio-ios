import UIKit
import NetworkKit
import RouterKit
import TokenKit

struct PasswordComposer {
    static func startScene(_ navigation: UINavigationController?, document: String) {
        let networkManager = NetworkManager.shared
        let coordinator = PasswordCoordinator(navigation: navigation, router: RoutingHub.shared)
        let service = PasswordService(networkManager)
        let tokenManager = PasswordTokenProvider(manager: TokenManager.shared)
        let viewModel = PasswordViewModel(
            coordinator: coordinator,
            service: service,
            tokenManager: tokenManager,
            document: document
        )
        let viewController = PasswordViewController(with: viewModel)

        coordinator.start(viewController: viewController)
    }
}
