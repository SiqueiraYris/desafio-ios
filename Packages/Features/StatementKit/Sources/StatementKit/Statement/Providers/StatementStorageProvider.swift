import StorageKit

protocol StatementStorageProviderProtocol {
    func getToken() -> String
}

final class StatementStorageProvider: StatementStorageProviderProtocol {
    // MARK: - Properties
    
    private let storageManager: StorageManagerProtocol

    // MARK: - Initializer

    init(storageManager: StorageManagerProtocol) {
        self.storageManager = storageManager
    }

    func getToken() -> String {
        return storageManager.load(from: .keychain, withKey: "auth-token", toType: String.self) ?? ""
    }
}
