import UIKit
import NetworkKit
import RouterKit

struct PasswordComposer {
    static func startScene(_ navigation: UINavigationController?, document: String) {
        let networkManager = NetworkManager.shared
        let coordinator = PasswordCoordinator(navigation: navigation, router: RoutingHub.shared)
        let service = PasswordService(networkManager)
        let storage = PasswordStorageProvider()
        let viewModel = PasswordViewModel(
            coordinator: coordinator,
            service: service,
            storage: storage,
            document: document
        )
        let viewController = PasswordViewController(with: viewModel)

        coordinator.start(viewController: viewController)
    }
}
