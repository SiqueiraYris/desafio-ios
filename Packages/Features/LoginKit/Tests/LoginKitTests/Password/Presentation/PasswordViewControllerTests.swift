import XCTest
import ComponentsKit
@testable import LoginKit

final class PasswordViewControllerTests: XCTestCase {
    // MARK: - Tests

    func test_init_shouldInitializeComponentsCorrectly() {
        let (sut, _) = makeSUT()
        let mirror = makeMirror(viewController: sut)

        XCTAssertFalse(mirror.titleLabel!.translatesAutoresizingMaskIntoConstraints)
        XCTAssertEqual(mirror.titleLabel?.text, Strings.passwordTitle)
        XCTAssertEqual(mirror.titleLabel?.textColor, Color.offBlack)
        XCTAssertEqual(mirror.titleLabel?.font, .bold(size: .x22))

        XCTAssertFalse(mirror.textField!.translatesAutoresizingMaskIntoConstraints)
        XCTAssertEqual(mirror.textField?.textColor, Color.offBlack)
        XCTAssertEqual(mirror.textField?.tintColor, Color.offBlack)
        XCTAssertEqual(mirror.textField?.font, .regular(size: .x22))
        XCTAssertTrue(mirror.textField?.isSecureTextEntry ?? false)

        XCTAssertEqual(mirror.primaryButton?.titleLabel?.text, Strings.passwordButtonTitle)
        XCTAssertFalse(mirror.primaryButton!.isEnabled)
    }

    // MARK: - Helpers

    private func makeSUT() -> (
        sut: PasswordViewController,
        viewModelSpy: PasswordViewModelSpy
    ) {
        let viewModelSpy = PasswordViewModelSpy()
        let sut = PasswordViewController(with: viewModelSpy)

        trackForMemoryLeaks(sut)
        trackForMemoryLeaks(viewModelSpy)

        return (sut, viewModelSpy)
    }

    private func makeMirror(viewController: PasswordViewController) -> PasswordViewControllerMirror {
        return PasswordViewControllerMirror(viewController: viewController)
    }
}
