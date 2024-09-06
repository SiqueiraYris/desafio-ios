import NetworkKit

enum StatementServiceRoute {
    case getTransactions(token: String)

    var config: RequestConfigProtocol {
        switch self {
        case let .getTransactions(token):
            return setupGetTransactionsRequest(token: token)
        }
    }

    private func setupGetTransactionsRequest(token: String) -> RequestConfigProtocol {
        let parameters = ["token": token]
        let config = RequestConfig(path: "/challenge/list",
                                   method: .get,
                                   headers: parameters, debugMode: true)
        return config
    }
}
