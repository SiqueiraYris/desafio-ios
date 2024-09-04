import UIKit
import ComponentsKit
@testable import LauncherKit

final class LauncherViewControllerMirror: MirrorObject {
    var logoImageView: UIImageView? {
        return extract()
    }

    var backgroundImageView: UIImageView? {
        return extract()
    }

    var titleLabel: Label? {
        return extract()
    }

    var subtitleLabel: Label? {
        return extract()
    }

    var primaryButton: Button? {
        return extract()
    }

    var secondaryButton: Button? {
        return extract()
    }

    init(viewController: LauncherViewController) {
        super.init(reflecting: viewController)
    }
}
