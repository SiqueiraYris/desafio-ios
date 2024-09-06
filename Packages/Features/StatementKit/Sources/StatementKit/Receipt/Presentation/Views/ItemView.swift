import UIKit
import ComponentsKit

final class ItemView: UIView {
    // MARK: - Views

    private let titleLabel: Label = {
        let label = Label(font: .regular(size: .x14))
        label.textColor = Color.offBlack
        return label
    }()

    private let subtitleLabel = Label()

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

    func setupViewObject(viewObject: ReceiptViewObject.Item) {
        titleLabel.text = viewObject.title
        subtitleLabel.attributedText = viewObject.value
    }

    private func setupViewStyle() {
        setupViewHierarchy()
        setupViewConstraints()
    }

    private func setupViewHierarchy() {
        addSubview(titleLabel)
        addSubview(subtitleLabel)
    }

    private func setupViewConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),

            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Spacing.x4),
            subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            subtitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
