@testable import LoginKit

final class PasswordStorageProviderSpy: PasswordStorageProviderProtocol {
    // MARK: - Properties
    
    enum Message: Equatable {
        case saveToken(token: String)
    }

    var receivedMessages = [Message]()

    // MARK: - Methods
    
    func saveToken(token: String) {
        receivedMessages.append(.saveToken(token: token))
    }
}
