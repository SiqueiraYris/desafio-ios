import UIKit
import ComponentsKit
@testable import StatementKit

final class StatementViewControllerMirror: MirrorObject {
    // MARK: - Properties

    var filterView: FilterView? {
        return extract()
    }

    var tableView: UITableView? {
        return extract()
    }

    var refreshControl: UIRefreshControl? {
        return extract()
    }

    var skeletonStackView: UIStackView? {
        return extract()
    }

    var viewModel: StatementViewModelProtocol? {
        return extract()
    }

    // MARK: - Initializer

    init(viewController: StatementViewController) {
        super.init(reflecting: viewController)
    }
}
