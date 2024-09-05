import DynamicKit

protocol ReceiptViewModelProtocol {
    var isLoading: Dynamic<Bool> { get }
    var viewObject: Dynamic<ReceiptViewObject?> { get }
}

final class ReceiptViewModel: ReceiptViewModelProtocol {
    // MARK: - Properties

    private let coordinator: ReceiptCoordinatorProtocol
    private let service: ReceiptServiceProtocol

    var isLoading = Dynamic(false)
    var viewObject: Dynamic<ReceiptViewObject?> = Dynamic(nil)

    // MARK: - Initializer

    init(coordinator: ReceiptCoordinatorProtocol,
         service: ReceiptServiceProtocol) {
        self.coordinator = coordinator
        self.service = service
    }

    // MARK: - Methods
}
