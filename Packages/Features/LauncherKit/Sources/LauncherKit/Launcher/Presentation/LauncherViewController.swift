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

    private let primaryButton: Button = {
        let button = Button(
            style: .primaryLight,
            size: .medium,
            title: Strings.primaryButtonTitle
        )
        button.setRightImage(Images.arrowRight)
        return button
    }()

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

    // MARK: - Life Cycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.isNavigationBarHidden = true
    }

    // MARK: - Methods

    private func setupViewStyle() {
        view.backgroundColor = Color.primaryMain

        secondaryButton.addTarget(self, action: #selector(didTapSecondaryButton), for: .touchUpInside)

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
                                               constant: Spacing.x12),
            logoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Spacing.x24),
            logoImageView.widthAnchor.constraint(equalToConstant: 90),
            logoImageView.heightAnchor.constraint(equalToConstant: 24),

            titleLabel.topAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: Spacing.x16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Spacing.x24),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Spacing.x24),

            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Spacing.x16),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Spacing.x24),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Spacing.x24),

            primaryButton.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: Spacing.x24),
            primaryButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Spacing.x24),
            primaryButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Spacing.x24),

            secondaryButton.topAnchor.constraint(equalTo: primaryButton.bottomAnchor, constant: Spacing.x16),
            secondaryButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Spacing.x24),
            secondaryButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Spacing.x24),
            secondaryButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                    constant: -Spacing.x16)
        ])
    }

    // MARK: - Actions

    @objc private func didTapSecondaryButton() {
        viewModel.openLogin()
    }
}
