import Foundation

public protocol TokenManagerProtocol: AnyObject {
    func setInitialToken(_ initialToken: String)
    func getToken(completion: @escaping (String?) -> Void)
}

public final class TokenManager: TokenManagerProtocol {
    public static let shared = TokenManager()

    private var token: String? {
        didSet {
            if token != nil && tokenRefreshTimer == nil {
                startTokenRefreshTimer()
            }
        }
    }
    private let semaphore = DispatchSemaphore(value: 1)
    private let service = TokenService()
    private var tokenRefreshTimer: Timer?

    private init() {}

    deinit {
        tokenRefreshTimer?.invalidate()
    }

    public func setInitialToken(_ initialToken: String) {
        semaphore.wait()
        token = initialToken
        semaphore.signal()
    }

    public func getToken(completion: @escaping (String?) -> Void) {
        semaphore.wait()
        if let token = token {
            semaphore.signal()
            completion(token)
        } else {
            semaphore.signal()
            completion(nil)
        }
    }

    private func updateToken(completion: @escaping (String?) -> Void) {
        service.refreshToken(route: .refresh(token: token ?? "")) { result in
            switch result {
            case let .success(tokenModel):
                completion(tokenModel.token)

            case .failure:
                completion(nil)
            }
        }
    }

    private func startTokenRefreshTimer() {
        tokenRefreshTimer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { [weak self] _ in
            self?.refreshToken()
        }
    }

    private func refreshToken() {
        print("aq")
        semaphore.wait()
        updateToken { [weak self] newToken in
            print("aq")
            self?.token = newToken
            self?.semaphore.signal()
        }
    }
}
