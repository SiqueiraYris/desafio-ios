import UIKit
import ComponentsKit

final class LauncherViewController: UIViewController {
    // MARK: - Views

    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: Images.logo)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: Images.background)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let titleLabel: Label = {
        let label = Label(text: Strings.title, font: .regular(size: .x28))
        label.textColor = .white
        return label
    }()

    private let subtitleLabel: Label = {
        let label = Label(text: Strings.subtitle, font: .regular(size: .x16))
        label.textColor = .white
        return label
    }()

    private let primaryButton = Button(
        style: .primaryLight,
        size: .medium,
        title: Strings.primaryButtonTitle
    )

    private let secondaryButton = Button(
        style: .secondaryDark,
        size: .small,
        title: Strings.secondaryButtonTitle
    )

    // MARK: - Properties

    private let viewModel: LauncherViewModelProtocol

    // MARK: - Initializer

    init(with viewModel: LauncherViewModelProtocol) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)

        setupViewStyle()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    private func setupViewStyle() {
        view.backgroundColor = Color.primaryMain

        setupViewHierarchy()
        setupViewConstraints()
    }

    private func setupViewHierarchy() {
        view.addSubview(backgroundImageView)
        view.addSubview(logoImageView)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(primaryButton)
        view.addSubview(secondaryButton)
    }

    private func setupViewConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                               constant: Spacing.sm),
            logoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Spacing.lg),
            logoImageView.widthAnchor.constraint(equalToConstant: 90),
            logoImageView.heightAnchor.constraint(equalToConstant: 24),

            titleLabel.topAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: Spacing.md),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Spacing.lg),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Spacing.lg),

            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Spacing.md),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Spacing.lg),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Spacing.lg),

            primaryButton.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: Spacing.lg),
            primaryButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Spacing.lg),
            primaryButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Spacing.lg),

            secondaryButton.topAnchor.constraint(equalTo: primaryButton.bottomAnchor, constant: Spacing.md),
            secondaryButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Spacing.lg),
            secondaryButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Spacing.lg),
            secondaryButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                    constant: -Spacing.md)
        ])
    }
}
