import XCTest
import DynamicKit
import NetworkKit
@testable import StatementKit

final class ReceiptViewModelTests: XCTestCase {
    // MARK: - Tests

    func test_fetch_withSuccessfulResponse_shouldUpdateViewObject() {
        let receiptModel = ReceiptModel.fixture()
        let type = "any-type"
        let (sut, serviceSpy, _) = makeSUT()

        serviceSpy.completeWithSuccess(object: receiptModel)
        sut.fetch()

        XCTAssertEqual(sut.isLoading.value, false)

        guard let viewObject = sut.viewObject.value else {
            XCTFail("Expected viewObject to not be nil")
            return
        }

        XCTAssertEqual(viewObject.title, receiptModel.toViewObject(type: type).title)
        XCTAssertEqual(viewObject.items.count, receiptModel.toViewObject(type: type).items.count)
        XCTAssertEqual(viewObject.icon, receiptModel.toViewObject(type: type).icon)
    }

    func test_fetch_withFailureResponse_shouldShowErrorAlert() {
        let error = ResponseError.fixture()
        let (sut, serviceSpy, coordinatorSpy) = makeSUT()

        serviceSpy.completeWithError(error: error)
        sut.fetch()

        XCTAssertEqual(sut.isLoading.value, false)
        XCTAssertEqual(coordinatorSpy.receivedMessages, [.showErrorAlert(message: error.responseErrorMessage)])
    }

    func test_share_shouldCallCoordinatorShare() {
        let dummyView = UIView()
        let (sut, _, coordinatorSpy) = makeSUT()

        sut.share(view: dummyView)

        XCTAssertEqual(coordinatorSpy.receivedMessages, [.share(view: dummyView)])
    }

    // MARK: - Helpers

    private func makeSUT(id: String = "any-id", type: String = "any-type") -> (
        sut: ReceiptViewModel,
        serviceSpy: ReceiptServiceSpy,
        coordinatorSpy: ReceiptCoordinatorSpy
    ) {
        let serviceSpy = ReceiptServiceSpy()
        let coordinatorSpy = ReceiptCoordinatorSpy()
        let sut = ReceiptViewModel(
            coordinator: coordinatorSpy,
            service: serviceSpy,
            id: id, 
            type: type
        )

        trackForMemoryLeaks(sut)
        trackForMemoryLeaks(serviceSpy)
        trackForMemoryLeaks(coordinatorSpy)

        return (sut, serviceSpy, coordinatorSpy)
    }
}
