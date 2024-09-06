import UIKit

public final class Button: UIButton {
    // MARK: - Properties
    
    private let style: Button.Style
    private let size: Button.Size
    private let title: String

    // MARK: - Initializer

    public init(
        style: Button.Style,
        size: Button.Size,
        title: String
    ) {
        self.style = style
        self.size = size
        self.title = title

        super.init(frame: .zero)

        setupViewStyle()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    public override var isEnabled: Bool {
        didSet {
            setupState()
        }
    }

    public func setRightImage(_ image: UIImage?, color: UIColor? = nil) {
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.x24).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        if let color = color {
            imageView.tintColor = color
        }
    }

    private func setupViewStyle() {
        translatesAutoresizingMaskIntoConstraints = false

        setupSize()
        setupStyle()
    }

    private func setupSize() {
        switch size {
        case .medium:
            let attributedTitle = NSAttributedString(string: title, attributes: [
                .font: UIFont.bold(size: .x16) as Any
            ])
            setAttributedTitle(attributedTitle, for: .normal)
            layer.cornerRadius = Border.CornerRadius.lg
            heightAnchor.constraint(equalToConstant: 64).isActive = true

        case .small:
            let attributedTitle = NSAttributedString(string: title, attributes: [
                .font: UIFont.bold(size: .x14) as Any
            ])
            setAttributedTitle(attributedTitle, for: .normal)
            layer.cornerRadius = Border.CornerRadius.md
            heightAnchor.constraint(equalToConstant: 48).isActive = true

        case .extraSmall:
            let attributedTitle = NSAttributedString(string: title, attributes: [
                .font: UIFont.regular(size: .x14) as Any
            ])
            setAttributedTitle(attributedTitle, for: .normal)
            heightAnchor.constraint(equalToConstant: 20).isActive = true
        }
    }

    private func setupStyle() {
        switch style {
        case .primaryLight:
            backgroundColor = Color.white
            setTitleColor(Color.primaryMain, for: .normal)
            tintColor = Color.primaryMain
            titleLabel?.translatesAutoresizingMaskIntoConstraints = false
            titleLabel?.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.x24).isActive = true

        case .primaryDark:
            backgroundColor = Color.primaryMain
            setTitleColor(Color.white, for: .normal)
            tintColor = Color.white
            titleLabel?.translatesAutoresizingMaskIntoConstraints = false
            titleLabel?.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.x24).isActive = true

        case .secondaryDark:
            setTitleColor(Color.white, for: .normal)
            tintColor = Color.white
            backgroundColor = Color.primaryMain

        case .tertiaryLight:
            backgroundColor = Color.white
            setTitleColor(Color.primaryMain, for: .normal)
            tintColor = Color.primaryMain
            contentHorizontalAlignment = .leading
        }
    }

    private func setupState() {
        if isEnabled {
            setupStyle()
        } else {
            backgroundColor = Color.gray2
            tintColor = Color.white
        }
    }
}
