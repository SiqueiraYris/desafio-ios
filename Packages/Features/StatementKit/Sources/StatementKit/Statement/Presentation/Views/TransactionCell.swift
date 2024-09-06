import UIKit
import ComponentsKit

final class TransactionCell: UITableViewCell {
    // MARK: - Views

    private let transactionView = TransactionView()

    // MARK: - Properties

    public static let reuseIdentifier = "TransactionCell"

    // MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViewStyle()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    func setupViewObject(viewObject: StatementViewObject.Row) {
        transactionView.setupViewObject(viewObject: viewObject)
    }

    private func setupViewStyle() {
        backgroundColor = .clear
        selectionStyle = .none

        setupViewHierarchy()
        setupViewConstraints()
    }

    private func setupViewHierarchy() {
        contentView.addSubview(transactionView)
    }

    private func setupViewConstraints() {
        NSLayoutConstraint.activate([
            transactionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Spacing.x24),
            transactionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Spacing.x24),
            transactionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Spacing.x24),
            transactionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Spacing.x8)
        ])
    }
}
