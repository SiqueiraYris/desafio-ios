import TokenKit

final class TokenManagerSpy: TokenManagerProtocol {
    // MARK: - Properties

    enum Message: Equatable {
        case setInitialToken(initialToken: String)
        case getToken
    }

    var receivedMessages = [Message]()
    var tokenToBeReturned: String?

    // MARK: - Methods

    func setInitialToken(_ initialToken: String) {
        receivedMessages.append(.setInitialToken(initialToken: initialToken))
    }

    func getToken(completion: @escaping (String?) -> Void) {
        receivedMessages.append(.getToken)
        completion(tokenToBeReturned)
    }
}
