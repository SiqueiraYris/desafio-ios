import NetworkKit

enum ReceiptServiceRoute: Equatable {
    case getDetails(id: String)
    
    var config: RequestConfigProtocol {
        switch self {
        case let .getDetails(id):
            return setupRequest(id: id)
        }
    }
    
    private func setupRequest(id: String) -> RequestConfigProtocol {
        let config = RequestConfig(
            path: "/challenge/details/\(id)",
            method: .get,
            refreshTokenEnabled: true
        )
        return config
    }
}
