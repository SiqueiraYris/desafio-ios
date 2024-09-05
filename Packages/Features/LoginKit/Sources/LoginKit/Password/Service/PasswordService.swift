import NetworkKit

enum PasswordServiceResult: Equatable {
    case success(LoginModel)
    case failure(ResponseError)
}

protocol PasswordServiceProtocol {
    func makeLogin(
        route: PasswordServiceRoute,
        completion: @escaping (PasswordServiceResult) -> Void
    )
}

final class PasswordService: PasswordServiceProtocol {
    // MARK: - Properties

    private let manager: NetworkManagerProtocol

    // MARK: - Initializer

    init(_ manager: NetworkManagerProtocol) {
        self.manager = manager
    }

    // MARK: - Methods

    func makeLogin(route: PasswordServiceRoute,
                   completion: @escaping (PasswordServiceResult) -> Void) {
        manager.request(with: route.config) { [weak self] managerResult in
            guard self != nil else { return }

            switch managerResult {
            case let .success(data):
                let serviceResult = DefaultResultMapper.map(data, to: LoginModel.self)

                switch serviceResult {
                case let.success(response as LoginModel):
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
