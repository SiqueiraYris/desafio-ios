@testable import LoginKit

final class LoginCoordinatorSpy: LoginCoordinatorProtocol {
    // MARK: - Properties

    enum Message: Equatable {
        case openPassword(document: String?)
    }

    var receivedMessages = [Message]()

    // MARK: - Methods

    func openPassword(document: String) {
        receivedMessages.append(.openPassword(document: document))
    }
}
