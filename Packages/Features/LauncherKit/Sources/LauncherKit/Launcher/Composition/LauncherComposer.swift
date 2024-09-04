import UIKit
import RouterKit

public struct LauncherComposer {
    public static func startScene(_ navigation: UINavigationController?) {
        let coordinator = LauncherCoordinator(navigation: navigation, router: RoutingHub.shared)
        let viewModel = LauncherViewModel(coordinator: coordinator)
        let viewController = LauncherViewController(with: viewModel)

        coordinator.start(viewController: viewController)
    }
}
