@testable import LauncherKit

final class LauncherViewModelSpy: LauncherViewModelProtocol {
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
