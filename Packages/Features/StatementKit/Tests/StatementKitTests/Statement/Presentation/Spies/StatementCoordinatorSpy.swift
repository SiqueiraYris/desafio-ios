@testable import StatementKit

final class StatementCoordinatorSpy: StatementCoordinatorProtocol {
    // MARK: - Properties

    enum Message: Equatable {
        case openDetails(id: String)
        case showErrorAlert(message: String)
    }

    var receivedMessages = [Message]()

    // MARK: - Methods

    func openDetails(id: String) {
        receivedMessages.append(.openDetails(id: id))
    }

    func showErrorAlert(with message: String, retryAction: @escaping () -> Void) {
        receivedMessages.append(.showErrorAlert(message: message))
    }
}
