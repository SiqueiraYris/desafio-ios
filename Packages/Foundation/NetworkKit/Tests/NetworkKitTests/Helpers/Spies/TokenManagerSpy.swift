@testable import NetworkKit

final class TokenManagerSpy: TokenManagerProtocol {
    // MARK: - Properties

    enum Message: Equatable {
        case setInitialToken(initialToken: String)
        case getToken
        case refreshToken
    }

    var receivedMessages = [Message]()
    var tokenToBeReturned: String?
    var refreshTokenToBeReturned: String?

    // MARK: - Methods

    func setInitialToken(_ initialToken: String) {
        receivedMessages.append(.setInitialToken(initialToken: initialToken))
    }

    func getToken(completion: @escaping (String?) -> Void) {
        receivedMessages.append(.getToken)
        completion(tokenToBeReturned)
    }

    func refreshToken(completion: @escaping (String?) -> Void) {
        receivedMessages.append(.refreshToken)
        completion(refreshTokenToBeReturned)
    }
}
