import XCTest
import ComponentsKit
@testable import LoginKit

final class LoginViewControllerTests: XCTestCase {
    // MARK: - Tests

    func test_init_shouldInitializeComponentsCorrectly() {
        let (sut, _) = makeSUT()
        let mirror = makeMirror(viewController: sut)

        XCTAssertFalse(mirror.titleLabel!.translatesAutoresizingMaskIntoConstraints)
        XCTAssertEqual(mirror.titleLabel?.text, Strings.loginTitle)
        XCTAssertEqual(mirror.titleLabel?.textColor, Color.gray1)
        XCTAssertEqual(mirror.titleLabel?.font, .regular(size: .x16))

        XCTAssertEqual(mirror.subtitleLabel?.text, Strings.loginSubtitle)
        XCTAssertEqual(mirror.subtitleLabel?.textColor, Color.offBlack)
        XCTAssertEqual(mirror.subtitleLabel?.font, .bold(size: .x22))

        XCTAssertFalse(mirror.textField!.translatesAutoresizingMaskIntoConstraints)
        XCTAssertEqual(mirror.textField?.textColor, Color.offBlack)
        XCTAssertEqual(mirror.textField?.tintColor, Color.offBlack)
        XCTAssertEqual(mirror.textField?.font, .regular(size: .x22))
        XCTAssertEqual(mirror.textField?.keyboardType, .numberPad)

        XCTAssertEqual(mirror.primaryButton?.titleLabel?.text, Strings.loginPrimaryButtonTitle)
        XCTAssertFalse(mirror.primaryButton!.isEnabled)
    }

    // MARK: - Helpers

    private func makeSUT() -> (
        sut: LoginViewController,
        viewModelSpy: LoginViewModelSpy
    ) {
        let viewModelSpy = LoginViewModelSpy()
        let sut = LoginViewController(with: viewModelSpy)

        trackForMemoryLeaks(sut)
        trackForMemoryLeaks(viewModelSpy)

        return (sut, viewModelSpy)
    }

    private func makeMirror(viewController: LoginViewController) -> LoginViewControllerMirror {
        return LoginViewControllerMirror(viewController: viewController)
    }
}
