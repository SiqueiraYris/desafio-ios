# StorageKit

`StorageKit` is intended for data storage on iOS. With this package it's possible save, delete and load data from User Defaults, Memory and Keychain.

## Architecture

The `StorageManager` in `StorageKit` is the main class responsible for managing data storage across different storage types, such as `UserDefaults`, `Keychain` and `memory. It utilizes a JSON provider for encoding and decoding objects and a set of storage providers to perform save, load, and delete operations.
The StorageManagerProtocol defines the essential methods for saving, loading, and deleting data from different storage types.

```swift
public protocol StorageManagerProtocol {
    func save<T: Encodable>(on storage: StorageType, withKey key: String, object: T)
    func load<T: Decodable>(from storage: StorageType, withKey key: String, toType type: T.Type) -> T?
    func delete(from storage: StorageType, withKey key: String)
}
```

## Usage

```swift
// Save a value in memory
StorageManager.shared.save(on: .memory, withKey: "userSessionToken", object: "abc123")

// Load a value from memory
if let token: String = StorageManager.shared.load(from: .memory, withKey: "userSessionToken", toType: String.self) {
    print("Session token: \(token)")
}

// Delete a value from memory
StorageManager.shared.delete(from: .memory, withKey: "userSessionToken")

// Clear all values from memory
StorageManager.shared.clear(storage: .memory)
```
