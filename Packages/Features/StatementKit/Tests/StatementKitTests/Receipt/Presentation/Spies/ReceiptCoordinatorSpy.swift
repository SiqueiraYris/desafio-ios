import UIKit
@testable import StatementKit

final class ReceiptCoordinatorSpy: ReceiptCoordinatorProtocol {
    // MARK: - Properties

    enum Message: Equatable {
        case showErrorAlert(message: String)
        case share(view: UIView)
    }

    var receivedMessages = [Message]()

    // MARK: - Methods

    func showErrorAlert(with message: String, retryAction: @escaping () -> Void) {
        receivedMessages.append(.showErrorAlert(message: message))
    }

    func share(view: UIView) {
        receivedMessages.append(.share(view: view))
    }
}
