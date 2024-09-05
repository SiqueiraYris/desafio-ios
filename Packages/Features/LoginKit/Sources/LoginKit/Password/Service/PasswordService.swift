import NetworkKit

enum PasswordServiceResult {
    case success(PasswordModel)
    case failure(ResponseError)
}

protocol PasswordServiceProtocol {
    func fetch(route: PasswordServiceRoute, completion: @escaping (PasswordServiceResult) -> Void)
}

final class PasswordService: PasswordServiceProtocol {
    // MARK: - Properties

    private let manager: NetworkManagerProtocol

    // MARK: - Initializer

    init(_ manager: NetworkManagerProtocol) {
        self.manager = manager
    }

    // MARK: - Methods

    func fetch(route: PasswordServiceRoute,
               completion: @escaping (PasswordServiceResult) -> Void) {
//        manager.request(with: route.config) { [weak self] managerResult in
//            guard self != nil else { return }
//
//            switch managerResult {
//            case let .success(data):
//                let serviceResult = ResultMapper.map(data, to: PasswordModel.self)
//
//                switch serviceResult {
//                case .success(let response as PasswordModel):
//                    completion(.success(response))
//
//                case .failure(let responseError):
//                    completion(.failure(responseError))
//
//                default:
//                    completion(.failure(ResponseError(apiError: nil)))
//                }
//
//            case let .failure(responseError):
//                completion(.failure(responseError))
//            }
//        }
    }
}
