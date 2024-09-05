import DynamicKit

protocol PasswordViewModelProtocol {
    var isLoading: Dynamic<Bool> { get }
    var viewObject: Dynamic<PasswordViewObject?> { get }
}

final class PasswordViewModel: PasswordViewModelProtocol {
    // MARK: - Properties

    private let coordinator: PasswordCoordinatorProtocol
    private let service: PasswordServiceProtocol
    private let document: String

    var isLoading = Dynamic(false)
    var viewObject: Dynamic<PasswordViewObject?> = Dynamic(nil)

    // MARK: - Initializer

    init(coordinator: PasswordCoordinatorProtocol,
         service: PasswordServiceProtocol,
         document: String) {
        self.coordinator = coordinator
        self.service = service
        self.document = document
    }

    // MARK: - Methods
}
