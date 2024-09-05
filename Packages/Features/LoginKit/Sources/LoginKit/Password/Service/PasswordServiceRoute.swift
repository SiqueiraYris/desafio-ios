import NetworkKit

enum PasswordServiceRoute {
    case prepare

    var config: RequestConfigProtocol {
        switch self {
        case .prepare:
            return setupRequest()
        }
    }

    private func setupRequest() -> RequestConfigProtocol {
        let config = RequestConfig(path: "",
                                   method: .get)
        return config
    }
}
