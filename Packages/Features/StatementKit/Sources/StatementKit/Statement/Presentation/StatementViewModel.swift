import DynamicKit
import UIKit

protocol StatementViewModelProtocol {
    var isLoading: Dynamic<Bool> { get }
    var shouldReloadData: Dynamic<Bool> { get }

    func fetch()
    func numberOfSections() -> Int
    func getSectionTitle(section: Int) -> String
    func numberOfRowsInSection(section: Int) -> Int
    func cellForRowAt(indexPath: IndexPath) -> StatementViewObject.Row?
    func didSelectRowAt(indexPath: IndexPath)
    func didSelectFilter(filter: FilterType)
}

final class StatementViewModel: StatementViewModelProtocol {
    // MARK: - Properties

    private let coordinator: StatementCoordinatorProtocol
    private let service: StatementServiceProtocol

    private var viewObject: StatementViewObject?

    var isLoading = Dynamic(false)
    var shouldReloadData: Dynamic<Bool> = Dynamic(false)

    // MARK: - Initializer

    init(coordinator: StatementCoordinatorProtocol,
         service: StatementServiceProtocol) {
        self.coordinator = coordinator
        self.service = service
    }

    // MARK: - Methods

    func fetch() {
        isLoading.value = true

        let route = StatementServiceRoute.getTransactions
        service.fetch(route: route) { [weak self] result in
            guard let self else { return }
            self.isLoading.value = false

            switch result {
            case let .success(statementModel):
                self.viewObject = statementModel.toViewObject()
                self.shouldReloadData.value = true

            case let .failure(responseError):
                self.coordinator.showErrorAlert(with: responseError.responseErrorMessage) {
                    self.fetch()
                }
            }
        }
    }

    func numberOfSections() -> Int {
        return viewObject?.sections.count ?? 0
    }

    func getSectionTitle(section: Int) -> String {
        return viewObject?.sections[safe: section]?.title ?? ""
    }

    func numberOfRowsInSection(section: Int) -> Int {
        return viewObject?.sections[safe: section]?.rows.count ?? 0
    }

    func cellForRowAt(indexPath: IndexPath) -> StatementViewObject.Row? {
        return viewObject?.sections[safe: indexPath.section]?.rows[safe: indexPath.row]
    }

    func didSelectRowAt(indexPath: IndexPath) {
        guard let item = viewObject?.sections[
            safe: indexPath.section
        ]?.rows[safe: indexPath.row] else { return }
        coordinator.openDetails(id: item.id, type: item.type)
    }
    
    func didSelectFilter(filter: FilterType) {

    }
}
