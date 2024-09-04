import UIKit

public final class Button: UIButton {
    private let style: Button.Style
    private let size: Button.Size

    public init(style: Button.Style, size: Button.Size, title: String? = nil) {
        self.style = style
        self.size = size

        super.init(frame: .zero)

        setTitle(title, for: .normal)
        setupViewStyle()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViewStyle() {
        translatesAutoresizingMaskIntoConstraints = false

        setupSize()
        setupStyle()
    }

    private func setupSize() {
        switch size {
        case .medium:
            layer.cornerRadius = 16
            titleLabel?.font = .boldSystemFont(ofSize: 16)
            heightAnchor.constraint(equalToConstant: 64).isActive = true

        case .small:
            layer.cornerRadius = 12
            titleLabel?.font = .boldSystemFont(ofSize: 14)
            heightAnchor.constraint(equalToConstant: 48).isActive = true
        }
    }

    private func setupStyle() {
        var config = UIButton.Configuration.borderless()

        switch style {
        case .primaryLight:
            config.titleAlignment = .trailing
            config.titlePadding = 0
            config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0)
            backgroundColor = Color.white
            setTitleColor(Color.primaryMain, for: .normal)
            contentHorizontalAlignment = .left

        case .primaryDark:
            config.titleAlignment = .trailing
            config.titlePadding = 0
            config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0)
            setTitleColor(Color.white, for: .normal)
            contentHorizontalAlignment = .left
            backgroundColor = Color.primaryMain

        case .secondaryDark:
            setTitleColor(Color.white, for: .normal)
            backgroundColor = Color.primaryMain

        case .secondaryLight:
            break
        }

        configuration = config
    }
}
