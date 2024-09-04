protocol LauncherViewModelProtocol {
    func openLogin()
}

final class LauncherViewModel: LauncherViewModelProtocol {
    // MARK: - Properties

    private let coordinator: LauncherCoordinatorProtocol

    // MARK: - Initializer

    init(coordinator: LauncherCoordinatorProtocol) {
        self.coordinator = coordinator
    }

    // MARK: - Methods

    func openLogin() {
        coordinator.openLogin()
    }
}
