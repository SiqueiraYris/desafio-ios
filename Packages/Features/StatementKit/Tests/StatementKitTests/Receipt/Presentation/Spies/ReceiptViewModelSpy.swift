import DynamicKit
import UIKit
@testable import StatementKit

final class ReceiptViewModelSpy: ReceiptViewModelProtocol {
    // MARK: - Properties

    var isLoading: Dynamic<Bool> = Dynamic(false)
    var viewObject: Dynamic<ReceiptViewObject?> = Dynamic(nil)

    enum Message: Equatable {
        case fetch
        case share(view: UIView)
    }

    var receivedMessages = [Message]()

    // MARK: - Methods

    func fetch() {
        receivedMessages.append(.fetch)
    }

    func share(view: UIView) {
        receivedMessages.append(.share(view: view))
    }
}
