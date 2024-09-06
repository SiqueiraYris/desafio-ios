import NetworkKit

enum StatementServiceRoute: Equatable {
    case getTransactions
    
    func config(token: String) -> RequestConfigProtocol {
        switch self {
        case .getTransactions:
            return setupGetTransactionsRequest(token: token)
        }
    }
    
    private func setupGetTransactionsRequest(token: String) -> RequestConfigProtocol {
        let parameters = ["token": token]
        let config = RequestConfig(
            path: "/challenge/list",
            method: .get,
            headers: parameters
        )
        return config
    }
}
