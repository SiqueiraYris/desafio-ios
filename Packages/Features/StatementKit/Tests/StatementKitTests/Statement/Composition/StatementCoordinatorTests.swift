import XCTest
@testable import StatementKit

final class StatementCoordinatorTests: XCTestCase {
    // MARK: - Tests

    func test_start_shouldStartSceneCorrectly() {
        let viewController = UIViewController()
        let (sut, navigator) = makeSUT()

        sut.start(viewController: viewController)

        XCTAssertFalse(navigator.isNavigationBarHidden)
        XCTAssertNotNil(viewController.isBeingPresented)
    }

    // MARK: - Helpers

    private func makeSUT() -> (
        sut: StatementCoordinator,
        navigator: UINavigationController
    ) {
        let navigator = UINavigationController()
        let sut = StatementCoordinator(navigation: navigator)

        trackForMemoryLeaks(sut)
        trackForMemoryLeaks(navigator)

        return (sut, navigator)
    }
}
