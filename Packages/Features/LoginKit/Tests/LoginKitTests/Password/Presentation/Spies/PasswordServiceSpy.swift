import NetworkKit
@testable import LoginKit

final class PasswordServiceSpy: PasswordServiceProtocol {
    // MARK: - Properties
    
    enum Message: Equatable {
        case makeLogin(route: PasswordServiceRoute)
    }

    var receivedMessages = [Message]()
    var result: PasswordServiceResult?

    // MARK: - Methods
    
    func makeLogin(
        route: PasswordServiceRoute,
        completion: @escaping (PasswordServiceResult) -> Void
    ) {
        receivedMessages.append(.makeLogin(route: route))
        if let result = result {
            completion(result)
        }
    }

    func completeWithSuccess(object: LoginModel) {
        result = .success(object)
    }

    func completeWithError(error: ResponseError) {
        result = .failure(error)
    }
}
