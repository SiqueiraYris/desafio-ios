import XCTest
@testable import StatementKit

final class ReceiptCoordinatorTests: XCTestCase {
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
        sut: ReceiptCoordinator,
        navigator: UINavigationController
    ) {
        let navigator = UINavigationController()
        let sut = ReceiptCoordinator(navigation: navigator)

        trackForMemoryLeaks(sut)
        trackForMemoryLeaks(navigator)

        return (sut, navigator)
    }
}
