import UIKit
import ComponentsKit

final class ReceiptViewController: UIViewController {
    // MARK: - Views

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let icon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let titleLabel: Label = {
        let label = Label(font: .bold(size: .x16))
        label.textColor = Color.offBlack
        return label
    }()

    private let itemsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let primaryButton: Button = {
        let button = Button(
            style: .primaryDark,
            size: .medium,
            title: Strings.receiptShareButtonTitle
        )
        let image = Images.download?.withRenderingMode(.alwaysTemplate)
        button.setRightImage(image, color: Color.offBlack)
        return button
    }()

    // MARK: - Properties

    private let viewModel: ReceiptViewModelProtocol

    // MARK: - Initializer

    init(with viewModel: ReceiptViewModelProtocol) {
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
        viewModel.fetch()
    }

    private func setupBindings() {
        viewModel.isLoading.bind { [weak self] isLoading in
            guard let self else { return }

            if isLoading {
                self.showSkeletonLoader(in: self.view)
                self.primaryButton.isHidden = true
            } else {
                self.hideSkeletonLoader()
                self.primaryButton.isHidden = false
            }
        }

        viewModel.viewObject.bind { [weak self] viewObject in
            self?.makeViews(viewObject: viewObject)
        }
    }

    private func setupViewStyle() {
        view.backgroundColor = .white
        title = Strings.receiptNavigationTitle

        primaryButton.addTarget(self, action: #selector(didTapShare), for: .touchUpInside)

        setupViewHierarchy()
        setupViewConstraints()
    }

    private func setupViewHierarchy() {
        view.addSubview(scrollView)
        view.addSubview(primaryButton)
        scrollView.addSubview(icon)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(itemsStackView)
    }

    private func setupViewConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: primaryButton.topAnchor, constant: -Spacing.x24),

            icon.widthAnchor.constraint(equalToConstant: 24),
            icon.heightAnchor.constraint(equalToConstant: 24),
            icon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Spacing.x24),
            icon.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),

            titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: Spacing.x32),
            titleLabel.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: Spacing.x8),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Spacing.x24),

            itemsStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Spacing.x24),
            itemsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Spacing.x24),
            itemsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Spacing.x24),
            itemsStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -Spacing.x24),

            primaryButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Spacing.x24),
            primaryButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Spacing.x24),
            primaryButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Spacing.x24)
        ])
    }

    private func makeViews(viewObject: ReceiptViewObject?) {
        guard let viewObject else { return }
        titleLabel.text = viewObject.title
        icon.image = viewObject.icon

        itemsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        viewObject.items.forEach {
            itemsStackView.addArrangedSubview($0)
        }
    }

    // MARK: - Actions

    @objc private func didTapShare() {
        viewModel.share(view: scrollView)
    }
}
