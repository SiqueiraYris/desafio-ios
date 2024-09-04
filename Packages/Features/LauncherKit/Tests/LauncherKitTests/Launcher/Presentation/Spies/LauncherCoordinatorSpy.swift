@testable import LauncherKit

final class LauncherCoordinatorSpy: LauncherCoordinatorProtocol {
    // MARK: - Properties

    enum Message: Equatable {
        case openLogin
    }

    var receivedMessages = [Message]()

    // MARK: - Methods

    func openLogin() {
        receivedMessages.append(.openLogin)
    }
}
