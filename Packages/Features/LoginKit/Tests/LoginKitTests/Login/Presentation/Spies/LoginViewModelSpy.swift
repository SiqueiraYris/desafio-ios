import DynamicKit
@testable import LoginKit

final class LoginViewModelSpy: LoginViewModelProtocol {
    // MARK: - Properties

    var isButtonEnabled: Dynamic<Bool> = Dynamic(false)
    var updatedDocument: Dynamic<String?> = Dynamic(nil)
    
    enum Message: Equatable {
        case validateDocument(text: String?)
        case openPassword(document: String?)
    }

    var receivedMessages = [Message]()

    // MARK: - Methods

    func validateDocument(text: String?) {
        receivedMessages.append(.validateDocument(text: text))
    }

    func openPassword(document: String?) {
        receivedMessages.append(.openPassword(document: document))
    }
}
