import NetworkKit
@testable import StatementKit

final class ReceiptServiceSpy: ReceiptServiceProtocol {
    // MARK: - Properties

    enum Message: Equatable {
        case fetch(route: ReceiptServiceRoute)
    }

    var receivedMessages = [Message]()
    var result: ReceiptServiceResult?

    // MARK: - Methods

    func fetch(
        route: ReceiptServiceRoute,
        completion: @escaping (ReceiptServiceResult) -> Void
    ) {
        receivedMessages.append(.fetch(route: route))
        if let result = result {
            completion(result)
        }
    }

    func completeWithSuccess(object: ReceiptModel) {
        result = .success(object)
    }

    func completeWithError(error: ResponseError) {
        result = .failure(error)
    }
}
