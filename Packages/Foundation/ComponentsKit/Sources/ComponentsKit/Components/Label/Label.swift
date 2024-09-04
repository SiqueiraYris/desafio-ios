import UIKit

public final class Label: UILabel {
    public init(text: String? = nil, font: UIFont? = nil) {
        super.init(frame: .zero)

        self.text = text
        self.font = font

        setupViewStyle()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewStyle() {
        translatesAutoresizingMaskIntoConstraints = false
        numberOfLines = 0
    }
}
