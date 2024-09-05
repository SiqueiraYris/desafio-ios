import NetworkKit

enum ReceiptServiceResult {
    case success(ReceiptModel)
    case failure(ResponseError)
}

protocol ReceiptServiceProtocol {
    func fetch(route: ReceiptServiceRoute, completion: @escaping (ReceiptServiceResult) -> Void)
}

final class ReceiptService: ReceiptServiceProtocol {
    // MARK: - Properties

    private let manager: NetworkManagerProtocol

    // MARK: - Initializer

    init(_ manager: NetworkManagerProtocol) {
        self.manager = manager
    }

    // MARK: - Methods

    func fetch(route: ReceiptServiceRoute,
               completion: @escaping (ReceiptServiceResult) -> Void) {
        manager.request(with: route.config) { [weak self] managerResult in
            guard self != nil else { return }

            switch managerResult {
            case let .success(data):
                let serviceResult = DefaultResultMapper.map(data, to: ReceiptModel.self)

                switch serviceResult {
                case .success(let response as ReceiptModel):
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
