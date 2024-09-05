import XCTest
@testable import LoginKit

final class LoginCoordinatorTests: XCTestCase {
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
        sut: LoginCoordinator,
        navigator: UINavigationController
    ) {
        let navigator = UINavigationController()
        let sut = LoginCoordinator(navigation: navigator)

        trackForMemoryLeaks(sut)
        trackForMemoryLeaks(navigator)

        return (sut, navigator)
    }
}
