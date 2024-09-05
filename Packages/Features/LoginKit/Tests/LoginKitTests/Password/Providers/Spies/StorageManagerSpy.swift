import StorageKit

final class StorageManagerSpy: StorageManagerProtocol {
    enum Message: Equatable {
        case save(storage: StorageType, key: String)
        case load(storage: StorageType, key: String)
        case delete(storage: StorageType, key: String)
    }

    var receivedMessages = [Message]()
    var loadResult: Any?

    func save<T: Encodable>(on storage: StorageType, withKey key: String, object: T) {
        receivedMessages.append(.save(storage: storage, key: key))
    }

    func load<T: Decodable>(from storage: StorageType, withKey key: String, toType type: T.Type) -> T? {
        receivedMessages.append(.load(storage: storage, key: key))
        return loadResult as? T
    }

    func delete(from storage: StorageType, withKey key: String) {
        receivedMessages.append(.delete(storage: storage, key: key))
    }

    func completeWithLoadResult<T: Decodable>(_ result: T?) {
        loadResult = result
    }
}
