import NetworkKit

enum TokenServiceRoute: Equatable {
    case refresh(token: String)

    var config: RequestConfigProtocol {
        switch self {
        case let .refresh(token):
            return setupRefreshRequest(token: token)
        }
    }

    private func setupRefreshRequest(token: String) -> RequestConfigProtocol {
        let parameters = ["token": token]
        let config = RequestConfig(
            path: "/challenge/auth",
            method: .post,
            encoding: .body,
            parameters: parameters, debugMode: true
        )
        return config
    }
}
