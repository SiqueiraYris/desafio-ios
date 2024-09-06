import UIKit
import ComponentsKit
@testable import StatementKit

final class ReceiptViewControllerMirror: MirrorObject {
    // MARK: - Properties

    var scrollView: UIScrollView? {
        return extract()
    }

    var icon: UIImageView? {
        return extract()
    }

    var titleLabel: Label? {
        return extract()
    }

    var itemsStackView: UIStackView? {
        return extract()
    }

    var primaryButton: Button? {
        return extract()
    }

    var viewModel: ReceiptViewModelProtocol? {
        return extract()
    }

    // MARK: - Initializer

    init(viewController: ReceiptViewController) {
        super.init(reflecting: viewController)
    }
}
