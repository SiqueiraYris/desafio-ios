import NetworkKit

enum ReceiptServiceRoute {
    case getDetails(id: String)

    func config(token: String) -> RequestConfigProtocol {
        switch self {
        case let .getDetails(id):
            return setupRequest(id: id, token: token)
        }
    }

    private func setupRequest(id: String, token: String) -> RequestConfigProtocol {
        let parameters = ["token": token]
        let config = RequestConfig(path: "/challenge/details/\(id)",
                                   method: .get,
                                   headers: parameters)
        return config
    }
}
