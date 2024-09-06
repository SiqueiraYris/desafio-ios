import Foundation

public protocol TokenManagerProtocol: AnyObject {
    func setInitialToken(_ token: String)
    func getToken(completion: @escaping (String?) -> Void)
    func refreshToken(completion: @escaping (String?) -> Void)
}

final class TokenManager: TokenManagerProtocol {
    // MARK: - Properties

    private var token: String?
    private var isRefreshing = false
    private let semaphore = DispatchSemaphore(value: 1)

    static let shared = TokenManager()

    // MARK: - Initializer
    
    private init() {}

    // MARK: - Methods

    func setInitialToken(_ token: String) {
        semaphore.wait()
        self.token = token
        semaphore.signal()
        startTokenRefreshTimer()
    }

    func getToken(completion: @escaping (String?) -> Void) {
        semaphore.wait()
        if let token = token {
            semaphore.signal()
            completion(token)
        } else {
            semaphore.signal()
            completion(nil)
        }
    }

    func refreshToken(completion: @escaping (String?) -> Void) {
        semaphore.wait()
        guard !isRefreshing else {
            semaphore.signal()
            return
        }

        isRefreshing = true
        semaphore.signal()

        let oldToken = token
        performTokenRefreshRequest(oldToken: oldToken) { [weak self] newToken in
            guard let self = self else { return }
            self.semaphore.wait()
            self.token = newToken
            self.isRefreshing = false
            self.semaphore.signal()
            completion(newToken)
        }
    }

    private func performTokenRefreshRequest(oldToken: String?, completion: @escaping (String?) -> Void) {
        NetworkManager.shared.request(with: TokenServiceRoute.refresh(token: oldToken ?? "").config) { managerResult in
            switch managerResult {
            case let .success(data):
                let serviceResult = DefaultResultMapper.map(data, to: TokenModel.self)

                switch serviceResult {
                case let.success(response as TokenModel):
                    completion(response.token)

                default:
                    completion(nil)
                }

            case .failure:
                completion(nil)
            }
        }
    }

    private func startTokenRefreshTimer() {
        Timer.scheduledTimer(withTimeInterval: 60.0, repeats: true) { [weak self] _ in
            self?.refreshToken(completion: { _ in })
        }
    }
}
