import UIKit
import ComponentsKit

final class TransactionView: UIView {
    // MARK: - Views

    private let iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let titleLabel = Label()

    private let subtitleLabel = Label(font: .regular(size: .x14))

    private let descriptionLabel: Label = {
        let label = Label(font: .regular(size: .x14))
        label.textColor = Color.gray1
        return label
    }()

    private let timeLabel: Label = {
        let label = Label(font: .regular(size: .x12))
        label.textColor = Color.gray1
        return label
    }()

    // MARK: - Properties

    public static let reuseIdentifier = "TransactionCell"

    // MARK: - Initializer

    init() {
        super.init(frame: .zero)

        setupViewStyle()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    func setupViewObject(viewObject: StatementViewObject.Row) {
        iconView.image = viewObject.icon
        titleLabel.attributedText = viewObject.title
        subtitleLabel.text = viewObject.subtitle
        subtitleLabel.textColor = viewObject.subtitleColor
        descriptionLabel.text = viewObject.description
        timeLabel.text = viewObject.time
    }

    private func setupViewStyle() {
        backgroundColor = Color.white

        setupViewHierarchy()
        setupViewConstraints()
    }

    private func setupViewHierarchy() {
        addSubview(iconView)
        addSubview(contentStackView)
        addSubview(timeLabel)

        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(subtitleLabel)
        contentStackView.addArrangedSubview(descriptionLabel)
    }

    private func setupViewConstraints() {
        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            iconView.topAnchor.constraint(equalTo: topAnchor),
            iconView.leadingAnchor.constraint(equalTo: leadingAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 24),
            iconView.heightAnchor.constraint(equalToConstant: 24),

            contentStackView.topAnchor.constraint(equalTo: topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: Spacing.x16),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentStackView.heightAnchor.constraint(equalToConstant: 64),

            timeLabel.leadingAnchor.constraint(equalTo: contentStackView.trailingAnchor, constant: Spacing.x8),
            timeLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            timeLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
