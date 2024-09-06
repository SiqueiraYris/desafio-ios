import XCTest
import DynamicKit
import NetworkKit
@testable import LoginKit

final class PasswordViewModelTests: XCTestCase {
    // MARK: - Tests

    func test_validatePassword_withValidPassword_shouldEnableButtonAndUpdateDocument() {
        let (sut, _, _) = makeSUT()

        sut.validatePassword(text: "123456")

        XCTAssertEqual(sut.updatedDocument.value, "123456")
        XCTAssertTrue(sut.isButtonEnabled.value)
    }

    func test_validatePassword_withShortPassword_shouldNotEnableButtonAndUpdateDocument() {
        let (sut, _, _) = makeSUT()

        sut.validatePassword(text: "123")

        XCTAssertEqual(sut.updatedDocument.value, "123")
        XCTAssertFalse(sut.isButtonEnabled.value)
    }

    func test_validatePassword_withNilText_shouldNotUpdateDocumentAndDisableButton() {
        let (sut, _, _) = makeSUT()

        sut.validatePassword(text: nil)

        XCTAssertNil(sut.updatedDocument.value)
        XCTAssertFalse(sut.isButtonEnabled.value)
    }

    func test_login_withValidPassword_shouldCallServiceAndOpenStatement() {
        let document = "12345678909"
        let password = "123456"
        let loginModel = LoginModel(token: "testToken")
        let (sut, serviceSpy, coordinatorSpy) = makeSUT(document: document)

        serviceSpy.completeWithSuccess(object: loginModel)
        sut.login(password: password)

        XCTAssertEqual(serviceSpy.receivedMessages, [.makeLogin(route: .login(document: document, password: password))])
        XCTAssertEqual(coordinatorSpy.receivedMessages, [.openStatement])
        XCTAssertFalse(sut.isLoading.value)
    }

    func test_login_withValidPasswordButReceiveSomeError_shouldOpensAlert() {
        let document = "12345678909"
        let password = "123456"
        let error = ResponseError.fixture()
        let (sut, serviceSpy, coordinatorSpy) = makeSUT(document: document)

        serviceSpy.completeWithError(error: error)
        sut.login(password: password)

        XCTAssertEqual(serviceSpy.receivedMessages, [.makeLogin(route: .login(document: document, password: password))])
        XCTAssertEqual(coordinatorSpy.receivedMessages, [.showErrorAlert(message: error.responseErrorMessage)])
        XCTAssertFalse(sut.isLoading.value)
    }

    func test_login_withNilPassword_shouldNotCallServiceAndNotChangeLoadingState() {
        let (sut, serviceSpy, _) = makeSUT()

        sut.login(password: nil)

        XCTAssertTrue(serviceSpy.receivedMessages.isEmpty)
        XCTAssertFalse(sut.isLoading.value)
    }

    func test_getImage_whenIsSecureEntry_shouldDeliversCorrectImage() {
        let (sut, _, _) = makeSUT()

        let image = sut.getImage(isSecureTextEntry: true)

        XCTAssertEqual(image, Images.eyeHidden)
    }

    func test_getImage_whenIsNotSecureEntry_shouldDeliversCorrectImage() {
        let (sut, _, _) = makeSUT()

        let image = sut.getImage(isSecureTextEntry: false)

        XCTAssertEqual(image, Images.eye)
    }

    // MARK: - Helpers

    private func makeSUT(document: String = "12345678909") -> (
        sut: PasswordViewModel,
        serviceSpy: PasswordServiceSpy,
        coordinatorSpy: PasswordCoordinatorSpy
    ) {
        let serviceSpy = PasswordServiceSpy()
        let coordinatorSpy = PasswordCoordinatorSpy()
        let sut = PasswordViewModel(
            coordinator: coordinatorSpy,
            service: serviceSpy,
            document: document
        )

        trackForMemoryLeaks(sut)
        trackForMemoryLeaks(serviceSpy)
        trackForMemoryLeaks(coordinatorSpy)

        return (sut, serviceSpy, coordinatorSpy)
    }
}
