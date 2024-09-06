import UIKit
@testable import StatementKit

extension ReceiptViewObject {
    static func fixture(
        icon: UIImage = UIImage(systemName: "plus.circle.fill")!,
        title: String = "any-title",
        items: [ItemView] = [ItemView(), ItemView()]
    ) -> ReceiptViewObject {
        return ReceiptViewObject(
            icon: icon,
            title: title,
            items: items
        )
    }
}
