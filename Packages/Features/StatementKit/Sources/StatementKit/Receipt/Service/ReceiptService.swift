import NetworkKit
import TokenKit

protocol ReceiptServiceProtocol {
    func fetch(route: ReceiptServiceRoute, completion: @escaping (ReceiptServiceResult) -> Void)
}

final class ReceiptService: ReceiptServiceProtocol {
    // MARK: - Properties

    private let manager: NetworkManagerProtocol
    private let tokenManager: TokenManagerProtocol

    // MARK: - Initializer

    init(_ manager: NetworkManagerProtocol, tokenManager: TokenManagerProtocol) {
        self.manager = manager
        self.tokenManager = tokenManager
    }

    // MARK: - Methods

    func fetch(route: ReceiptServiceRoute,
               completion: @escaping (ReceiptServiceResult) -> Void) {
        tokenManager.getToken { [weak self] token in
            self?.manager.request(with: route.config(token: token ?? "")) { managerResult in
                switch managerResult {
                case let .success(data):
                    let serviceResult = DefaultResultMapper.map(data, to: ReceiptModel.self)

                    switch serviceResult {
                    case let .success(response as ReceiptModel):
                        completion(.success(response))

                    case let .failure(responseError):
                        completion(.failure(responseError))

                    default:
                        completion(.failure(ResponseError(error: .unknownFailure)))
                    }

                case let .failure(responseError):
                    completion(.failure(responseError))
                }
            }
        }
    }
}
