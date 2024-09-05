import UIKit
import ComponentsKit

final class LoginViewController: UIViewController {
    // MARK: - Views

    private let titleLabel: Label = {
        let label = Label(text: Strings.loginTitle, font: .regular(size: .x16))
        label.textColor = Color.gray1
        return label
    }()

    private let subtitleLabel: Label = {
        let label = Label(text: Strings.loginSubtitle, font: .bold(size: .x22))
        label.textColor = Color.offBlack
        return label
    }()

    private let textField: UITextField = {
        let textField = UITextField()
        textField.textColor = Color.offBlack
        textField.tintColor = Color.offBlack
        textField.font = .regular(size: .x22)
        textField.keyboardType = .numberPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let primaryButton: Button = {
        let button = Button(
            style: .primaryDark,
            size: .small,
            title: Strings.loginPrimaryButtonTitle
        )
        button.setRightImage(Images.arrowRight)
        button.isEnabled = false
        return button
    }()

    // MARK: - Properties

    private let viewModel: LoginViewModelProtocol
    private var bottomConstraint: NSLayoutConstraint?
    private let bottomConstraintInitialValue: CGFloat = -Spacing.x24

    // MARK: - Initializer

    init(with viewModel: LoginViewModelProtocol) {
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
        resetFocus()
    }

    // MARK: - Methods

    override func animateKeyboard(withHeight height: CGFloat, showingKeyboard: Bool) {
        let buttonBottomOffset = (height + abs(bottomConstraintInitialValue)) - view.safeAreaInsets.bottom
        bottomConstraint?.constant = showingKeyboard ? -buttonBottomOffset : bottomConstraintInitialValue
    }

    private func setup() {
        setupDismissKeyboard()
        registerKeyboardNotifications()
        setupBindings()
        setupViewStyle()
    }

    private func setupBindings() {
        viewModel.isButtonEnabled.bind { [weak self] isEnabled in
            self?.primaryButton.isEnabled = isEnabled
        }

        viewModel.updatedDocument.bind { [weak self] text in
            self?.textField.text = text
        }
    }

    private func setupViewStyle() {
        view.backgroundColor = Color.white
        title = Strings.loginNavigationTitle

        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        primaryButton.addTarget(self, action: #selector(didTapPrimaryButton), for: .touchUpInside)

        setupViewHierarchy()
        setupViewConstraints()
    }

    private func setupViewHierarchy() {
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(textField)
        view.addSubview(primaryButton)
    }

    private func setupViewConstraints() {
        bottomConstraint = primaryButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                                 constant: -Spacing.x16)
        bottomConstraint?.isActive = true

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                            constant: Spacing.x24),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                constant: Spacing.x24),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                 constant: -Spacing.x24),

            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Spacing.x8),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                   constant: Spacing.x24),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                    constant: -Spacing.x24),

            textField.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: Spacing.x32),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                               constant: Spacing.x24),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                constant: -Spacing.x24),

            primaryButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                   constant: Spacing.x24),
            primaryButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                    constant: -Spacing.x24)
        ])
    }

    private func resetFocus() {
        textField.becomeFirstResponder()
    }

    // MARK: - Actions

    @objc private func textFieldDidChange(_ textField: UITextField) {
        viewModel.validateDocument(text: textField.text)
    }

    @objc private func didTapPrimaryButton() {
        viewModel.openPassword(document: textField.text)
    }
}
