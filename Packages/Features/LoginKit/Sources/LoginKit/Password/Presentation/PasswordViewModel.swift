import DynamicKit

protocol PasswordViewModelProtocol {
    var isLoading: Dynamic<Bool> { get }
    var viewObject: Dynamic<PasswordViewObject?> { get }
}

final class PasswordViewModel: PasswordViewModelProtocol {
    // MARK: - Properties

    private let coordinator: PasswordCoordinatorProtocol
    private let service: PasswordServiceProtocol

    var isLoading = Dynamic(false)
    var viewObject: Dynamic<PasswordViewObject?> = Dynamic(nil)

    // MARK: - Initializer

    init(coordinator: PasswordCoordinatorProtocol,
         service: PasswordServiceProtocol) {
        self.coordinator = coordinator
        self.service = service
    }

    // MARK: - Methods
}
