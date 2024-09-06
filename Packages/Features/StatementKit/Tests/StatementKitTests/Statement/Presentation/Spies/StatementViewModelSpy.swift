import DynamicKit
import UIKit
@testable import StatementKit

final class StatementViewModelSpy: StatementViewModelProtocol {
    // MARK: - Properties

    var isLoading: Dynamic<Bool> = Dynamic(false)
    var shouldReloadData: Dynamic<Bool> = Dynamic(false)

    enum Message: Equatable {
        case fetch
        case numberOfSections
        case getSectionTitle(section: Int)
        case numberOfRowsInSection(section: Int)
        case cellForRowAt(indexPath: IndexPath)
        case didSelectRowAt(indexPath: IndexPath)
        case didSelectFilter(filter: FilterType)
        case share(view: UIView)
    }

    var receivedMessages = [Message]()

    var numberOfSectionsToBeReturned: Int = 0
    var sectionTitleToBeReturned: String = ""
    var numberOfRowsToBeReturned: Int = 0
    var rowToBeReturned: StatementViewObject.Row?

    // MARK: - Methods

    func fetch() {
        receivedMessages.append(.fetch)
    }

    func numberOfSections() -> Int {
        receivedMessages.append(.numberOfSections)
        return numberOfSectionsToBeReturned
    }

    func getSectionTitle(section: Int) -> String {
        receivedMessages.append(.getSectionTitle(section: section))
        return sectionTitleToBeReturned
    }

    func numberOfRowsInSection(section: Int) -> Int {
        receivedMessages.append(.numberOfRowsInSection(section: section))
        return numberOfRowsToBeReturned
    }

    func cellForRowAt(indexPath: IndexPath) -> StatementViewObject.Row? {
        receivedMessages.append(.cellForRowAt(indexPath: indexPath))
        return rowToBeReturned
    }

    func didSelectRowAt(indexPath: IndexPath) {
        receivedMessages.append(.didSelectRowAt(indexPath: indexPath))
    }

    func didSelectFilter(filter: FilterType) {
        receivedMessages.append(.didSelectFilter(filter: filter))
    }

    func share(view: UIView) {
        receivedMessages.append(.share(view: view))
    }
}
