import NetworkKit

protocol TokenServiceProtocol {
    func refreshToken(
        route: TokenServiceRoute,
        completion: @escaping (TokenServiceResult) -> Void
    )
}

final class TokenService: TokenServiceProtocol {
    // MARK: - Properties

    private let manager: NetworkManagerProtocol

    // MARK: - Initializer

    init(_ manager: NetworkManagerProtocol = NetworkManager.shared) {
        self.manager = manager
    }

    // MARK: - Methods

    func refreshToken(
        route: TokenServiceRoute,
        completion: @escaping (TokenServiceResult) -> Void
    ) {
        manager.request(with: route.config) { managerResult in
            switch managerResult {
            case let .success(data):
                let serviceResult = DefaultResultMapper.map(data, to: TokenModel.self)

                switch serviceResult {
                case let.success(response as TokenModel):
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
