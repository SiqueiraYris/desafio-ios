import DynamicKit
import UIKit

protocol ReceiptViewModelProtocol {
    var isLoading: Dynamic<Bool> { get }
    var viewObject: Dynamic<ReceiptViewObject?> { get }

    func fetch()
    func share(view: UIView)
}

final class ReceiptViewModel: ReceiptViewModelProtocol {
    // MARK: - Properties

    private let coordinator: ReceiptCoordinatorProtocol
    private let service: ReceiptServiceProtocol
    private let id: String
    private let type: String

    var isLoading = Dynamic(false)
    var viewObject: Dynamic<ReceiptViewObject?> = Dynamic(nil)

    // MARK: - Initializer

    init(coordinator: ReceiptCoordinatorProtocol,
         service: ReceiptServiceProtocol,
         id: String,
         type: String) {
        self.coordinator = coordinator
        self.service = service
        self.id = id
        self.type = type
    }

    // MARK: - Methods

    func fetch() {
        isLoading.value = true
        let route = ReceiptServiceRoute.getDetails(id: id)
        service.fetch(route: route) { [weak self] result in
            guard let self else { return }
            self.isLoading.value = false

            switch result {
            case let .success(receiptModel):
                self.viewObject.value = receiptModel.toViewObject(type: self.type)

            case let .failure(responseError):
                self.coordinator.showErrorAlert(with: responseError.responseErrorMessage) {
                    self.fetch()
                }
            }
        }
    }

    func share(view: UIView) {
        coordinator.share(view: view)
    }
}
