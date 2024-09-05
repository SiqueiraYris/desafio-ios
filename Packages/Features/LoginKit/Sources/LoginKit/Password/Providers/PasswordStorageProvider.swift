import StorageKit

protocol PasswordStorageProviderProtocol {
    func saveToken(token: String)
}

final class PasswordStorageProvider: PasswordStorageProviderProtocol {
    private let storageManager: StorageManagerProtocol

    init(storageManager: StorageManagerProtocol) {
        self.storageManager = storageManager
    }

    func saveToken(token: String) {
        storageManager.save(on: .keychain, withKey: "auth-token", object: token)
    }
}
