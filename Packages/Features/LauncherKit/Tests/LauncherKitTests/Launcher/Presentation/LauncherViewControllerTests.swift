import XCTest
import ComponentsKit
@testable import LauncherKit

final class LauncherViewControllerTests: XCTestCase {
    // MARK: - Tests

    func test_init_shouldInitializeComponentsCorrectly() {
        let (sut, _) = makeSUT()
        let mirror = makeMirror(viewController: sut)

        XCTAssertFalse(mirror.logoImageView!.translatesAutoresizingMaskIntoConstraints)
        XCTAssertEqual(mirror.logoImageView?.image, Images.logo)
        XCTAssertEqual(mirror.logoImageView?.contentMode, .scaleAspectFit)

        XCTAssertTrue(mirror.backgroundImageView!.clipsToBounds)
        XCTAssertFalse(mirror.backgroundImageView!.translatesAutoresizingMaskIntoConstraints)
        XCTAssertEqual(mirror.backgroundImageView?.image, Images.background)
        XCTAssertEqual(mirror.backgroundImageView?.contentMode, .scaleAspectFill)

        XCTAssertFalse(mirror.titleLabel!.translatesAutoresizingMaskIntoConstraints)
        XCTAssertEqual(mirror.titleLabel?.text, Strings.title)
        XCTAssertEqual(mirror.titleLabel?.textColor, .white)
        XCTAssertEqual(mirror.titleLabel?.font, .regular(size: .x28))

        XCTAssertEqual(mirror.subtitleLabel?.text, Strings.subtitle)
        XCTAssertEqual(mirror.subtitleLabel?.textColor, .white)
        XCTAssertEqual(mirror.subtitleLabel?.font, .regular(size: .x16))

        XCTAssertEqual(mirror.primaryButton?.titleLabel?.text, Strings.primaryButtonTitle)
    }

    // MARK: - Helpers

    private func makeSUT() -> (
        sut: LauncherViewController,
        viewModelSpy: LauncherViewModelSpy
    ) {
        let viewModelSpy = LauncherViewModelSpy()
        let sut = LauncherViewController(with: viewModelSpy)
        _ = sut.view

        trackForMemoryLeaks(sut)
        trackForMemoryLeaks(viewModelSpy)

        return (sut, viewModelSpy)
    }

    private func makeMirror(viewController: LauncherViewController) -> LauncherViewControllerMirror {
        return LauncherViewControllerMirror(viewController: viewController)
    }
}
