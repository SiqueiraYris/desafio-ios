import DynamicKit
import UIKit
@testable import LoginKit

final class PasswordViewModelSpy: PasswordViewModelProtocol {
    // MARK: - Properties

    var isLoading: Dynamic<Bool> = Dynamic(false)
    var isButtonEnabled: Dynamic<Bool> = Dynamic(false)
    var updatedDocument: Dynamic<String?> = Dynamic(nil)

    enum Message: Equatable {
        case validatePassword(text: String?)
        case login(password: String?)
        case getImage(isSecureTextEntry: Bool)
    }

    var receivedMessages = [Message]()
    var imageToBeReturned: UIImage?

    // MARK: - Methods

    func validatePassword(text: String?) {
        receivedMessages.append(.validatePassword(text: text))
    }

    func login(password: String?) {
        receivedMessages.append(.login(password: password))
    }

    func getImage(isSecureTextEntry: Bool) -> UIImage? {
        receivedMessages.append(.getImage(isSecureTextEntry: isSecureTextEntry))
        return imageToBeReturned
    }
}
