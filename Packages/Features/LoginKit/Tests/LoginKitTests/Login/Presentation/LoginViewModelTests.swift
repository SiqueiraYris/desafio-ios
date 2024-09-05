import XCTest
@testable import LoginKit

final class LoginViewModelTests: XCTestCase {
    // MARK: - Tests

    func test_validateDocument_withValidCPF_shouldEnableButtonAndUpdateDocument() {
        let (sut, _) = makeSUT()

        sut.validateDocument(text: "123.456.789-09")

        XCTAssertEqual(sut.updatedDocument.value, "123.456.789-09")
        XCTAssertTrue(sut.isButtonEnabled.value)
    }

    func test_validateDocument_withInvalidCPF_shouldNotEnableButtonAndUpdateDocument() {
        let (sut, _) = makeSUT()

        sut.validateDocument(text: "123.456.789-00")

        XCTAssertEqual(sut.updatedDocument.value, "123.456.789-00")
        XCTAssertFalse(sut.isButtonEnabled.value)
    }

    func test_validateDocument_withNilText_shouldNotUpdateDocumentAndDisableButton() {
        let (sut, _) = makeSUT()

        sut.validateDocument(text: nil)

        XCTAssertNil(sut.updatedDocument.value)
        XCTAssertFalse(sut.isButtonEnabled.value)
    }

    func test_openPassword_shouldCallCoordinatorWithCorrectDocument() {
        let (sut, coordinatorSpy) = makeSUT()
        let document = "12345678909"

        sut.openPassword(document: document)

        XCTAssertEqual(coordinatorSpy.receivedMessages, [.openPassword(document: document)])
    }

    // MARK: - Helpers

    private func makeSUT() -> (
        sut: LoginViewModel,
        coordinatorSpy: LoginCoordinatorSpy
    ) {
        let coordinatorSpy = LoginCoordinatorSpy()
        let sut = LoginViewModel(coordinator: coordinatorSpy)

        trackForMemoryLeaks(sut)
        trackForMemoryLeaks(coordinatorSpy)

        return (sut, coordinatorSpy)
    }
}
