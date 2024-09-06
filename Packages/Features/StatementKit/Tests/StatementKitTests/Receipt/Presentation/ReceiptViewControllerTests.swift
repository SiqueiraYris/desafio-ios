import XCTest
import ComponentsKit
@testable import StatementKit

final class ReceiptViewControllerTests: XCTestCase {
    // MARK: - Tests

    func test_init_shouldInitializeComponentsCorrectly() {
        let (sut, _) = makeSUT()
        let mirror = makeMirror(viewController: sut)

        XCTAssertFalse(mirror.scrollView!.translatesAutoresizingMaskIntoConstraints)
        XCTAssertFalse(mirror.icon!.translatesAutoresizingMaskIntoConstraints)
        XCTAssertFalse(mirror.itemsStackView!.translatesAutoresizingMaskIntoConstraints)

        XCTAssertEqual(mirror.titleLabel?.textColor, Color.offBlack)
    }

    func test_viewDidLoad_shouldTriggerViewModelFetch() {
        let (sut, viewModelSpy) = makeSUT()

        _ = sut.view

        XCTAssertEqual(viewModelSpy.receivedMessages, [.fetch])
    }

    func test_viewWillAppear_shouldSetupNavigationBar() {
        let (sut, _) = makeSUT()
        sut.viewWillAppear(false)

        XCTAssertEqual(sut.title, Strings.receiptNavigationTitle)
    }

    func test_bindings_shouldHandleLoadingStateCorrectly() {
        let (sut, viewModelSpy) = makeSUT()
        let mirror = makeMirror(viewController: sut)

        viewModelSpy.isLoading.value = true
        XCTAssertTrue(mirror.primaryButton!.isHidden)

        viewModelSpy.isLoading.value = false
        XCTAssertFalse(mirror.primaryButton!.isHidden)
    }

    func test_makeViews_shouldUpdateViewCorrectly() {
        let receiptViewObject = ReceiptViewObject.fixture()
        let (sut, viewModelSpy) = makeSUT()
        let mirror = makeMirror(viewController: sut)

        viewModelSpy.viewObject.value = receiptViewObject

        XCTAssertEqual(mirror.titleLabel?.text, receiptViewObject.title)
        XCTAssertEqual(mirror.icon?.image, receiptViewObject.icon)
        XCTAssertEqual(mirror.itemsStackView?.arrangedSubviews.count, receiptViewObject.items.count)
    }

    // MARK: - Helpers

    private func makeSUT() -> (
        sut: ReceiptViewController,
        viewModelSpy: ReceiptViewModelSpy
    ) {
        let viewModelSpy = ReceiptViewModelSpy()
        let sut = ReceiptViewController(with: viewModelSpy)

        trackForMemoryLeaks(sut)
        trackForMemoryLeaks(viewModelSpy)

        return (sut, viewModelSpy)
    }

    private func makeMirror(viewController: ReceiptViewController) -> ReceiptViewControllerMirror {
        return ReceiptViewControllerMirror(viewController: viewController)
    }
}
