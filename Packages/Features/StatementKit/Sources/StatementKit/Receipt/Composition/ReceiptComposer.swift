import UIKit
import NetworkKit

struct ReceiptComposer {
    static func startScene(_ navigation: UINavigationController?, id: String, type: String) {
        let networkManager = NetworkManager.shared
        let coordinator = ReceiptCoordinator(navigation: navigation)
        let service = ReceiptService(networkManager)
        let viewModel = ReceiptViewModel(
            coordinator: coordinator,
            service: service, 
            id: id,
            type: type
        )
        let viewController = ReceiptViewController(with: viewModel)

        coordinator.start(viewController: viewController)
    }
}
