import UIKit

final class PasswordViewController: UIViewController {
    // MARK: - Views

    // MARK: - Properties

    private let viewModel: PasswordViewModelProtocol

    // MARK: - Initializer

    init(with viewModel: PasswordViewModelProtocol) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)

        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        view.backgroundColor = .white

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
