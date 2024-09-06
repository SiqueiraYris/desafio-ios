import TokenKit

protocol StatementTokenProviderProtocol {
    func getToken(completion: @escaping (String?) -> Void)
}

final class StatementTokenProvider: StatementTokenProviderProtocol {
    // MARK: - Properties
    
    private let manager: TokenManagerProtocol

    // MARK: - Initializer

    init(manager: TokenManagerProtocol) {
        self.manager = manager
    }

    func getToken(completion: @escaping (String?) -> Void) {
        return manager.getToken(completion: completion)
    }
}
