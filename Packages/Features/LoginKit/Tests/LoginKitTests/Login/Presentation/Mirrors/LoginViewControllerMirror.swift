import UIKit
import ComponentsKit
@testable import LoginKit

final class LoginViewControllerMirror: MirrorObject {
    // MARK: - Properties

    var titleLabel: Label? {
        return extract()
    }

    var subtitleLabel: Label? {
        return extract()
    }

    var textField: UITextField? {
        return extract()
    }

    var primaryButton: Button? {
        return extract()
    }

    // MARK: - Initializer
    
    init(viewController: LoginViewController) {
        super.init(reflecting: viewController)
    }
}
