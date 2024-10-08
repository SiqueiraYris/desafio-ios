import NetworkKit
@testable import LoginKit

final class NetworkManagerSpy: NetworkManagerProtocol {
    var completionPassed: ((PasswordServiceResult) -> Void)?
    var result: ResponseResult?

    enum Message: Equatable {
        case request(result: PasswordServiceResult)
        case setInitialToken(token: String)
    }

    var receivedMessages = [Message]()

    func completeWithSuccess(result: PasswordServiceResult) {
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

    func setInitialToken(_ token: String) {
        receivedMessages.append(.setInitialToken(token: token))
    }
}
