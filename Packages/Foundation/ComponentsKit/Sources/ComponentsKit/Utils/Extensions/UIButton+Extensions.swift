import UIKit

public extension UIButton {
    func addUnderline(withExtraSpacing extraSpacing: CGFloat = 5.0) {
        guard let title = title(for: .normal) else { return }

        let attributedString = NSMutableAttributedString(string: title)
        attributedString.addAttribute(
            .underlineStyle,
            value: NSUnderlineStyle.single.rawValue,
            range: NSRange(location: 0, length: title.count)
        )
        attributedString.addAttribute(
            .baselineOffset,
            value: extraSpacing,
            range: NSRange(location: 0, length: title.count)
        )

        setAttributedTitle(attributedString, for: .normal)
    }
}
