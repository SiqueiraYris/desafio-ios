import DynamicKit

protocol StatementViewModelProtocol {
    var isLoading: Dynamic<Bool> { get }
    var viewObject: Dynamic<StatementViewObject?> { get }
}

final class StatementViewModel: StatementViewModelProtocol {
    // MARK: - Properties

    private let coordinator: StatementCoordinatorProtocol
    private let service: StatementServiceProtocol

    var isLoading = Dynamic(false)
    var viewObject: Dynamic<StatementViewObject?> = Dynamic(nil)

    // MARK: - Initializer

    init(coordinator: StatementCoordinatorProtocol,
         service: StatementServiceProtocol) {
        self.coordinator = coordinator
        self.service = service
    }

    // MARK: - Methods
}
