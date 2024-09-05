@testable import LoginKit

final class PasswordCoordinatorSpy: PasswordCoordinatorProtocol {
    // MARK: - Properties

    enum Message: Equatable {
        case openStatement
    }

    var receivedMessages = [Message]()

    // MARK: - Methods

    func openStatement() {
        receivedMessages.append(.openStatement)
    }
}
