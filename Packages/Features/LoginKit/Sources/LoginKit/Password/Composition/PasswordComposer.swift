import UIKit
import NetworkKit
import RouterKit
import StorageKit

struct PasswordComposer {
    static func startScene(_ navigation: UINavigationController?, document: String) {
        let networkManager = NetworkManager.shared
        let coordinator = PasswordCoordinator(navigation: navigation, router: RoutingHub.shared)
        let service = PasswordService(networkManager)
        let storage = PasswordStorageProvider(storageManager: StorageManager.shared)
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
