import UIKit
import ComponentsKit

final class TransactionHeaderView: UIView {
    // MARK: - Views

    private let titleLabel: Label = {
        let label = Label(font: .regular(size: .x12))
        label.textColor = Color.gray1
        return label
    }()

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

    func setupViewObject(title: String) {
        titleLabel.text = title
    }

    private func setupViewStyle() {
        backgroundColor = Color.gray4

        setupViewHierarchy()
        setupViewConstraints()
    }

    private func setupViewHierarchy() {
        addSubview(titleLabel)
    }

    private func setupViewConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Spacing.x6),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.x24),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.x24),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Spacing.x6)
        ])
    }
}
