import TokenKit

protocol PasswordTokenProviderProtocol {
    func saveToken(token: String)
}

final class PasswordTokenProvider: PasswordTokenProviderProtocol {
    private let manager: TokenManagerProtocol

    init(manager: TokenManagerProtocol) {
        self.manager = manager
    }

    func saveToken(token: String) {
        manager.setInitialToken(token)
    }
}
