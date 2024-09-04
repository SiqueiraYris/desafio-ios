import XCTest
@testable import LauncherKit

final class LauncherViewModelTests: XCTestCase {
    // MARK: - Tests

    func test_openLogin_shouldOpensLoginCorrectly() {
        let (sut, coordinatorSpy) = makeSUT()

        sut.openLogin()

        XCTAssertEqual(coordinatorSpy.receivedMessages, [.openLogin])
    }

    // MARK: - Helpers

    private func makeSUT() -> (
        sut: LauncherViewModel,
        coordinatorSpy: LauncherCoordinatorSpy
    ) {
        let coordinatorSpy = LauncherCoordinatorSpy()
        let sut = LauncherViewModel(coordinator: coordinatorSpy)

        trackForMemoryLeaks(sut)
        trackForMemoryLeaks(coordinatorSpy)

        return (sut, coordinatorSpy)
    }
}
