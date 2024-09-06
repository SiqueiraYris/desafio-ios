import UIKit
import ComponentsKit

protocol FilterViewDelegate: AnyObject {
    func filterView(didSelectFilter filter: FilterType)
}

enum FilterType {
    case all
    case incoming
    case outgoing
    case future
    case filter
}

final class FilterView: UIView {
    // MARK: - Views

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        stackView.spacing = 20
        return stackView
    }()

    private let allButton = UIButton()
    private let incomingButton = UIButton()
    private let outgoingButton = UIButton()
    private let futureButton = UIButton()
    private let filterButton = UIButton()

    // MARK: - Properties

    weak var delegate: FilterViewDelegate?

    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViewStyle()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods

    private func setupViewStyle() {
        setupViewHierarchy()
        setupViewConstraints()

        setupButton(allButton, title: Strings.filterOptionAll, isSelected: true)
        setupButton(incomingButton, title: Strings.filterOptionIncoming)
        setupButton(outgoingButton, title: Strings.filterOptionOutgoing)
        setupButton(futureButton, title: Strings.filterOptionFuture)

        filterButton.setImage(Images.filter, for: .normal)
        filterButton.tintColor = Color.primaryMain

        allButton.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        incomingButton.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        outgoingButton.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        futureButton.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        filterButton.addTarget(self, action: #selector(didTapFilterButton), for: .touchUpInside)
    }

    private func setupViewHierarchy() {
        addSubview(stackView)
        stackView.addArrangedSubview(allButton)
        stackView.addArrangedSubview(incomingButton)
        stackView.addArrangedSubview(outgoingButton)
        stackView.addArrangedSubview(futureButton)
        addSubview(filterButton)
    }

    private func setupViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        filterButton.translatesAutoresizingMaskIntoConstraints = false
        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.x16),
            stackView.trailingAnchor.constraint(equalTo: filterButton.leadingAnchor, constant: -Spacing.x16),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),

            filterButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.x16),
            filterButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            filterButton.widthAnchor.constraint(equalToConstant: 24),
            filterButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }

    private func setupButton(_ button: UIButton, title: String, isSelected: Bool = false) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(isSelected ? Color.primaryMain : Color.gray1, for: .normal)
        button.titleLabel?.font = isSelected ? UIFont.bold(size: .x14) : UIFont.regular(size: .x14)
        if isSelected {
            button.addUnderline()
        }
    }

    private func resetButtonStyles() {
        let buttons = [allButton, incomingButton, outgoingButton, futureButton]
        buttons.forEach { button in
            button.setTitleColor(Color.gray1, for: .normal)
            let title = button.title(for: .normal) ?? ""
            button.setAttributedTitle(NSAttributedString(string: title), for: .normal)
        }
    }

    // MARK: - Actions

    @objc private func didTapButton(_ sender: UIButton) {
        resetButtonStyles()

        sender.setTitleColor(Color.primaryMain, for: .normal)
        sender.addUnderline()

        var selectedFilter: FilterType
        switch sender {
        case incomingButton:
            selectedFilter = .incoming

        case outgoingButton:
            selectedFilter = .outgoing

        case futureButton:
            selectedFilter = .future

        default:
            selectedFilter = .all
        }

        delegate?.filterView(didSelectFilter: selectedFilter)
    }

    @objc private func didTapFilterButton() { }
}
