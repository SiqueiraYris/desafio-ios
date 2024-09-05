import DynamicKit
@testable import LoginKit

final class PasswordViewModelSpy: PasswordViewModelProtocol {
    // MARK: - Properties

    var isLoading: Dynamic<Bool> = Dynamic(false)
    var isButtonEnabled: Dynamic<Bool> = Dynamic(false)
    var updatedDocument: Dynamic<String?> = Dynamic(nil)

    enum Message: Equatable {
        case validatePassword(text: String?)
        case login(password: String?)
    }

    var receivedMessages = [Message]()

    // MARK: - Methods

    func validatePassword(text: String?) {
        receivedMessages.append(.validatePassword(text: text))
    }

    func login(password: String?) {
        receivedMessages.append(.login(password: password))
    }
}
