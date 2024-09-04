import XCTest
@testable import LauncherKit

final class LauncherCoordinatorTests: XCTestCase {
    // MARK: - Tests

    func test_start_shouldStartSceneCorrectly() {
        let viewController = UIViewController()
        let (sut, _, _) = makeSUT()

        sut.start(viewController: viewController)

        XCTAssertNotNil(viewController.isBeingPresented)
    }

    func test_openLogin_shouldOpenLoginCorrectly() {
        let expectedURL = URL(string: "challenge-app://login")!
        let (sut, navigator, routingHubSpy) = makeSUT()

        sut.openLogin()

        XCTAssertEqual(
            routingHubSpy.receivedMessages,
            [.start(url: expectedURL, navigation: navigator)]
        )
    }

    // MARK: - Helpers

    private func makeSUT() -> (
        sut: LauncherCoordinator,
        navigator: UINavigationController,
        routingHubSpy: RoutingHubSpy
    ) {
        let navigator = UINavigationController()
        let routingHubSpy = RoutingHubSpy()
        let sut = LauncherCoordinator(navigation: navigator, router: routingHubSpy)

        trackForMemoryLeaks(sut)
        trackForMemoryLeaks(navigator)
        trackForMemoryLeaks(routingHubSpy)

        return (sut, navigator, routingHubSpy)
    }
}
