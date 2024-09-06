import NetworkKit
import TokenKit

enum StatementServiceResult: Equatable {
    case success(StatementModel)
    case failure(ResponseError)
}

protocol StatementServiceProtocol {
    func fetch(route: StatementServiceRoute, completion: @escaping (StatementServiceResult) -> Void)
}

final class StatementService: StatementServiceProtocol {
    // MARK: - Properties

    private let manager: NetworkManagerProtocol
    private let tokenManager: TokenManagerProtocol

    // MARK: - Initializer

    init(_ manager: NetworkManagerProtocol, tokenManager: TokenManagerProtocol) {
        self.manager = manager
        self.tokenManager = tokenManager
    }

    // MARK: - Methods

    func fetch(route: StatementServiceRoute,
               completion: @escaping (StatementServiceResult) -> Void) {
        tokenManager.getToken { [weak self] token in
            self?.manager.request(with: route.config(token: token ?? "")) { managerResult in
                switch managerResult {
                case let .success(data):
                    let serviceResult = DefaultResultMapper.map(data, to: StatementModel.self)

                    switch serviceResult {
                    case let .success(response as StatementModel):
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
