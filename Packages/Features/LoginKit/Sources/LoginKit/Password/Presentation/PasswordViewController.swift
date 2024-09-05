import UIKit
import ComponentsKit

final class PasswordViewController: UIViewController {
    // MARK: - Views

    private let titleLabel: Label = {
        let label = Label(text: Strings.passwordTitle, font: .bold(size: .x22))
        label.textColor = Color.offBlack
        return label
    }()

    private let textField: UITextField = {
        let textField = UITextField()
        textField.textColor = Color.offBlack
        textField.tintColor = Color.offBlack
        textField.font = .regular(size: .x22)
        textField.isSecureTextEntry = true
        let iconView = UIImageView(image: Images.eyeHidden)
        iconView.contentMode = .scaleAspectFit
        iconView.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        textField.rightView = iconView
        textField.rightViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let tertiaryButton: Button = {
        let button = Button(
            style: .tertiaryLight,
            size: .extraSmall,
            title: Strings.passwordTertiaryButtonTitle
        )
        return button
    }()

    private let primaryButton: Button = {
        let button = Button(
            style: .primaryDark,
            size: .small,
            title: Strings.passwordButtonTitle
        )
        button.setRightImage(Images.arrowRight)
        button.isEnabled = false
        return button
    }()

    // MARK: - Properties

    private let viewModel: PasswordViewModelProtocol

    private var bottomConstraint: NSLayoutConstraint?
    private let bottomConstraintInitialValue: CGFloat = -Spacing.x24

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
        viewModel.isLoading.bind { [weak self] isLoading in
            isLoading ? self?.showLoader() : self?.hideLoader()
        }

        viewModel.isButtonEnabled.bind { [weak self] isEnabled in
            self?.primaryButton.isEnabled = isEnabled
        }

        viewModel.updatedDocument.bind { [weak self] text in
            self?.textField.text = text
        }
    }

    private func setupViewStyle() {
        view.backgroundColor = Color.white
        title = Strings.passwordNavigationTitle

        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        primaryButton.addTarget(self, action: #selector(didTapPrimaryButton), for: .touchUpInside)

        setupViewHierarchy()
        setupViewConstraints()
    }

    private func setupViewHierarchy() {
        view.addSubview(titleLabel)
        view.addSubview(textField)
        view.addSubview(tertiaryButton)
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

            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Spacing.x32),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                               constant: Spacing.x24),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                constant: -Spacing.x24),

            tertiaryButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: Spacing.x48),
            tertiaryButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                               constant: Spacing.x24),
            tertiaryButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,
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
        viewModel.validatePassword(text: textField.text)
    }

    @objc private func didTapPrimaryButton() {
        viewModel.login(password: textField.text)
    }
}
