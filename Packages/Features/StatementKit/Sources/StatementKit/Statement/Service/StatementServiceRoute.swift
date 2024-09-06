import NetworkKit

enum StatementServiceRoute: Equatable {
    case getTransactions
    
    var config: RequestConfigProtocol {
        switch self {
        case .getTransactions:
            return setupGetTransactionsRequest()
        }
    }
    
    private func setupGetTransactionsRequest() -> RequestConfigProtocol {
        let config = RequestConfig(
            path: "/challenge/list",
            method: .get,
            refreshTokenEnabled: true
        )
        return config
    }
}
