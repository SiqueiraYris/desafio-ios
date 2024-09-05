import NetworkKit

enum StatementServiceResult {
    case success(StatementModel)
    case failure(ResponseError)
}

protocol StatementServiceProtocol {
    func fetch(route: StatementServiceRoute, completion: @escaping (StatementServiceResult) -> Void)
}

final class StatementService: StatementServiceProtocol {
    // MARK: - Properties

    private let manager: NetworkManagerProtocol

    // MARK: - Initializer

    init(_ manager: NetworkManagerProtocol) {
        self.manager = manager
    }

    // MARK: - Methods

    func fetch(route: StatementServiceRoute,
               completion: @escaping (StatementServiceResult) -> Void) {
        manager.request(with: route.config) { [weak self] managerResult in
            guard self != nil else { return }

            switch managerResult {
            case let .success(data):
                let serviceResult = DefaultResultMapper.map(data, to: StatementModel.self)

                switch serviceResult {
                case .success(let response as StatementModel):
                    completion(.success(response))

                case .failure(let responseError):
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
