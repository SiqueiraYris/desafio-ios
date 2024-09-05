import XCTest
@testable import LoginKit

final class PasswordCoordinatorTests: XCTestCase {
    // MARK: - Tests

    func test_start_shouldStartSceneCorrectly() {
        let viewController = UIViewController()
        let (sut, _, _) = makeSUT()

        sut.start(viewController: viewController)

        XCTAssertNotNil(viewController.isBeingPresented)
    }

    func test_openStatement_shouldOpenStatementCorrectly() {
        let expectedURL = URL(string: "challenge-app://statement")!
        let (sut, navigator, routingHubSpy) = makeSUT()

        sut.openStatement()

        XCTAssertEqual(
            routingHubSpy.receivedMessages,
            [.start(url: expectedURL, navigation: navigator)]
        )
    }

    // MARK: - Helpers

    private func makeSUT() -> (
        sut: PasswordCoordinator,
        navigator: UINavigationController,
        routingHubSpy: RoutingHubSpy
    ) {
        let navigator = UINavigationController()
        let routingHubSpy = RoutingHubSpy()
        let sut = PasswordCoordinator(navigation: navigator, router: routingHubSpy)

        trackForMemoryLeaks(sut)
        trackForMemoryLeaks(navigator)
        trackForMemoryLeaks(routingHubSpy)

        return (sut, navigator, routingHubSpy)
    }
}
