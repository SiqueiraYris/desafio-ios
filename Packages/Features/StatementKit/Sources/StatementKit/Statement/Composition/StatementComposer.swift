import UIKit
import NetworkKit

public struct StatementComposer {
    public static func startScene(_ navigation: UINavigationController?) {
        let networkManager = NetworkManager.shared
        let coordinator = StatementCoordinator(navigation: navigation)
        let service = StatementService(networkManager)
        let viewModel = StatementViewModel(coordinator: coordinator, service: service)
        let viewController = StatementViewController(with: viewModel)

        coordinator.start(viewController: viewController)
    }
}
