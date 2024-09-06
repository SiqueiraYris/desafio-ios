import XCTest
import DynamicKit
import NetworkKit
@testable import StatementKit

final class StatementViewModelTests: XCTestCase {
    // MARK: - Tests

    func test_fetch_withSuccessfulResponse_shouldUpdateViewObjectAndReloadData() {
        let statementModel = StatementModel.fixture()
        let (sut, serviceSpy, _) = makeSUT()

        serviceSpy.completeWithSuccess(object: statementModel)
        sut.fetch()

        XCTAssertEqual(sut.isLoading.value, false)
        XCTAssertTrue(sut.shouldReloadData.value)
        XCTAssertEqual(serviceSpy.receivedMessages, [.fetch(route: .getTransactions)])
    }

    func test_fetch_withFailureResponse_shouldShowErrorAlert() {
        let error = ResponseError.fixture()
        let (sut, serviceSpy, coordinatorSpy) = makeSUT()

        serviceSpy.completeWithError(error: error)
        sut.fetch()

        XCTAssertEqual(sut.isLoading.value, false)
        XCTAssertEqual(coordinatorSpy.receivedMessages, [.showErrorAlert(message: error.responseErrorMessage)])
    }

    func test_numberOfSections_shouldReturnCorrectValue() {
        let statementModel = StatementModel.fixture()
        let (sut, serviceSpy, _) = makeSUT()

        serviceSpy.completeWithSuccess(object: statementModel)
        sut.fetch()

        let numberOfSections = sut.numberOfSections()

        XCTAssertEqual(numberOfSections, statementModel.toViewObject().sections.count)
    }

    func test_getSectionTitle_shouldReturnCorrectTitle() {
        let statementModel = StatementModel.fixture()
        let (sut, serviceSpy, _) = makeSUT()

        serviceSpy.completeWithSuccess(object: statementModel)
        sut.fetch()

        let sectionTitle = sut.getSectionTitle(section: 0)

        XCTAssertEqual(sectionTitle, statementModel.toViewObject().sections.first?.title)
    }

    func test_numberOfRowsInSection_shouldReturnCorrectValue() {
        let statementModel = StatementModel.fixture()
        let (sut, serviceSpy, _) = makeSUT()

        serviceSpy.completeWithSuccess(object: statementModel)
        sut.fetch()

        let numberOfRows = sut.numberOfRowsInSection(section: 0)

        XCTAssertEqual(numberOfRows, statementModel.toViewObject().sections.first?.rows.count)
    }

    func test_cellForRowAt_shouldReturnCorrectRow() {
        let statementModel = StatementModel.fixture()
        let (sut, serviceSpy, _) = makeSUT()

        serviceSpy.completeWithSuccess(object: statementModel)
        sut.fetch()

        let row = sut.cellForRowAt(indexPath: IndexPath(row: 0, section: 0))

        XCTAssertEqual(row?.description, statementModel.toViewObject().sections.first?.rows.first?.description)
    }

    func test_didSelectRowAt_shouldOpenDetails() {
        let statementModel = StatementModel.fixture()
        let (sut, serviceSpy, coordinatorSpy) = makeSUT()

        serviceSpy.completeWithSuccess(object: statementModel)
        sut.fetch()

        sut.didSelectRowAt(indexPath: IndexPath(row: 0, section: 0))

        XCTAssertEqual(coordinatorSpy.receivedMessages, [
            .openDetails(
                id: statementModel.toViewObject().sections.first?.rows.first?.id ?? "",
                type: statementModel.toViewObject().sections.first?.rows.first?.type ?? ""
            )
        ])
    }

    // MARK: - Helpers

    private func makeSUT() -> (
        sut: StatementViewModel,
        serviceSpy: StatementServiceSpy,
        coordinatorSpy: StatementCoordinatorSpy
    ) {
        let serviceSpy = StatementServiceSpy()
        let coordinatorSpy = StatementCoordinatorSpy()
        let sut = StatementViewModel(
            coordinator: coordinatorSpy,
            service: serviceSpy
        )

        trackForMemoryLeaks(sut)
        trackForMemoryLeaks(serviceSpy)
        trackForMemoryLeaks(coordinatorSpy)

        return (sut, serviceSpy, coordinatorSpy)
    }
}
