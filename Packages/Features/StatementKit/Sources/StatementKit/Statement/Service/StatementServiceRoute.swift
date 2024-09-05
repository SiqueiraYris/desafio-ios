import NetworkKit

enum StatementServiceRoute {
    case prepare

    var config: RequestConfigProtocol {
        switch self {
        case .prepare:
            return setupRequest()
        }
    }

    private func setupRequest() -> RequestConfigProtocol {
        let config = RequestConfig(path: "/challenge/list",
                                   method: .get)
        return config
    }
}
