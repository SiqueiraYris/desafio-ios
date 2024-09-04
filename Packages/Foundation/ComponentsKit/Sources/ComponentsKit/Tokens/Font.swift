import UIKit

public extension UIFont {
    static func regular(size: FontSize) -> UIFont? {
        let font = UIFont(name: "Avenir-Roman", size: size.rawValue)
        return font
    }

    static func bold(size: FontSize) -> UIFont? {
        let font = UIFont(name: "Avenir-Heavy", size: size.rawValue)
        return font
    }
}
