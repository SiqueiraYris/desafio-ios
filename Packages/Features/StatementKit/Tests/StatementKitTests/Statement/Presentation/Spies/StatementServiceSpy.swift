import NetworkKit
@testable import StatementKit

final class StatementServiceSpy: StatementServiceProtocol {
    // MARK: - Properties

    enum Message: Equatable {
        case fetch(route: StatementServiceRoute)
    }

    var receivedMessages = [Message]()
    var result: StatementServiceResult?

    // MARK: - Methods

    func fetch(
        route: StatementServiceRoute,
        completion: @escaping (StatementServiceResult) -> Void
    ) {
        receivedMessages.append(.fetch(route: route))
        if let result = result {
            completion(result)
        }
    }

    func completeWithSuccess(object: StatementModel) {
        result = .success(object)
    }

    func completeWithError(error: ResponseError) {
        result = .failure(error)
    }
}
