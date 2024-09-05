import UIKit
import ComponentsKit

final class StatementViewController: UIViewController {
    // MARK: - Views

    // MARK: - Properties

    private let viewModel: StatementViewModelProtocol

    // MARK: - Initializer

    init(with viewModel: StatementViewModelProtocol) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)

        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setupNavigationBar()
    }

    // MARK: - Methods

    private func setup() {
        setupBindings()
        setupViewStyle()
    }

    private func setupBindings() {
        // it calls view model to perform APIs calls and listen to view objects
    }

    private func setupViewStyle() {
        view.backgroundColor = Color.white

        setupViewHierarchy()
        setupViewConstraints()
    }

    private func setupViewHierarchy() {
//        view.addSubview()
    }

    private func setupViewConstraints() {
//        NSLayoutConstraint.activate([
//        ])
    }
}
