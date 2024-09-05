import XCTest
@testable import LoginKit

final class PasswordStorageProviderTests: XCTestCase {
    // MARK: - Tests

    func test_saveToken_shouldSaveTokenToKeychain() {
        let (sut, storageManagerSpy) = makeSUT()
        let token = "any-token"

        sut.saveToken(token: token)

        XCTAssertEqual(storageManagerSpy.receivedMessages, [
            .save(storage: .keychain, key: "auth-token")
        ])
    }

    // MARK: - Helpers

    private func makeSUT() -> (
        sut: PasswordStorageProvider,
        storageManagerSpy: StorageManagerSpy
    ) {
        let storageManagerSpy = StorageManagerSpy()
        let sut = PasswordStorageProvider(storageManager: storageManagerSpy)

        trackForMemoryLeaks(sut)
        trackForMemoryLeaks(storageManagerSpy)

        return (sut, storageManagerSpy)
    }
}
