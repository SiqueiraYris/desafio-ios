@testable import LoginKit

final class PasswordCoordinatorSpy: PasswordCoordinatorProtocol {
    // MARK: - Properties

    enum Message: Equatable {
        case openStatement
        case showErrorAlert(message: String)
    }

    var receivedMessages = [Message]()

    // MARK: - Methods

    func openStatement() {
        receivedMessages.append(.openStatement)
    }

    func showErrorAlert(with message: String, retryAction: @escaping () -> Void) {
        receivedMessages.append(.showErrorAlert(message: message))
    }
}
