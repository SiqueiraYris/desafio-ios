import XCTest
import TokenKit
@testable import LoginKit

final class PasswordTokenProviderTests: XCTestCase {
    // MARK: - Tests

    func test_saveToken_shouldCallSetInitialTokenOnManager() {
        let (sut, tokenManagerSpy) = makeSUT()

        sut.saveToken(token: "sample_token")

        XCTAssertEqual(tokenManagerSpy.receivedMessages, [.setInitialToken(initialToken: "sample_token")])
    }

    func test_saveToken_withEmptyToken_shouldCallSetInitialTokenOnManagerWithEmptyString() {
        let (sut, tokenManagerSpy) = makeSUT()

        sut.saveToken(token: "")

        XCTAssertEqual(tokenManagerSpy.receivedMessages, [.setInitialToken(initialToken: "")])
    }

    func test_saveToken_shouldNotCallGetTokenOnManager() {
        let (sut, tokenManagerSpy) = makeSUT()

        sut.saveToken(token: "sample_token")

        XCTAssertFalse(tokenManagerSpy.receivedMessages.contains(.getToken))
    }

    // MARK: - Helpers

    private func makeSUT() -> (
        sut: PasswordTokenProvider,
        tokenManagerSpy: TokenManagerSpy
    ) {
        let tokenManagerSpy = TokenManagerSpy()
        let sut = PasswordTokenProvider(manager: tokenManagerSpy)

        trackForMemoryLeaks(sut)
        trackForMemoryLeaks(tokenManagerSpy)

        return (sut, tokenManagerSpy)
    }
}
