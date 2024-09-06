import NetworkKit
import StorageKit

enum ReceiptServiceRoute {
    case getDetails(id: String)

    var config: RequestConfigProtocol {
        switch self {
        case let .getDetails(id):
            return setupRequest(id: id)
        }
    }

    private func setupRequest(id: String) -> RequestConfigProtocol {
        let token = StorageManager.shared.load(from: .keychain, withKey: "auth-token", toType: String.self) ?? ""
        let parameters = ["token": token]
        let config = RequestConfig(path: "/challenge/details/\(id)",
                                   method: .get,
                                   headers: parameters)
        return config
    }
}
