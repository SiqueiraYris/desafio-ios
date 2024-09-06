import NetworkKit
@testable import StatementKit

final class NetworkManagerSpy: NetworkManagerProtocol {
    var completionPassed: ((StatementServiceResult) -> Void)?
    var result: ResponseResult?

    enum Message: Equatable {
        case request(result: StatementServiceResult)
    }

    var receivedMessages = [Message]()

    func completeWithSuccess(result: StatementServiceResult) {
        completionPassed?(result)
    }

    func completeWithError(error: ResponseError) {
        completionPassed?(.failure(error))
    }

    func request(with config: NetworkKit.RequestConfigProtocol, completion: @escaping (ResponseResult) -> Void) {
        completionPassed = { [weak self] response in
            self?.receivedMessages.append(.request(result: response))
        }
        completion(result!)
    }
}
