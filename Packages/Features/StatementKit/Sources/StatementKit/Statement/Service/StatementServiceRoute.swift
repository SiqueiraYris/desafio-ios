import NetworkKit
import StorageKit

enum StatementServiceRoute {
    case getTransactions

    var config: RequestConfigProtocol {
        switch self {
        case .getTransactions:
            return setupGetTransactionsRequest()
        }
    }

    private func setupGetTransactionsRequest() -> RequestConfigProtocol {
        let token = StorageManager.shared.load(from: .keychain, withKey: "auth-token", toType: String.self) ?? ""
        let parameters = ["token": token]
        let config = RequestConfig(path: "/challenge/list",
                                   method: .get,
                                   headers: parameters, debugMode: true)
        return config
    }
}
