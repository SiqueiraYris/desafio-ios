import UIKit
import ComponentsKit
@testable import LoginKit

final class PasswordViewControllerMirror: MirrorObject {
    // MARK: - Properties

    var titleLabel: Label? {
        return extract()
    }

    var textField: UITextField? {
        return extract()
    }

    var tertiaryButton: Button? {
        return extract()
    }

    var primaryButton: Button? {
        return extract()
    }

    // MARK: - Initializer

    init(viewController: PasswordViewController) {
        super.init(reflecting: viewController)
    }
}
