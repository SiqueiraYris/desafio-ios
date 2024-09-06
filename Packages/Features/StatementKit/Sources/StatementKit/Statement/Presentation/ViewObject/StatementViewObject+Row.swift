import UIKit

extension StatementViewObject {
    struct Row: Equatable {
        let id: String
        let icon: UIImage?
        let title: NSAttributedString?
        let subtitle: String?
        let subtitleColor: UIColor?
        let description: String?
        let time: String
    }
}
