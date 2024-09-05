import NetworkKit

enum PasswordServiceRoute: Equatable {
    case login(document: String, password: String)

    var config: RequestConfigProtocol {
        switch self {
        case let .login(document, password):
            return setupRequest(document: document, password: password)
        }
    }

    private func setupRequest(document: String, password: String) -> RequestConfigProtocol {
        let parameters = ["cpf": document,
                          "password": password]
        let config = RequestConfig(
            path: "/challenge/auth",
            method: .post,
            encoding: .body,
            parameters: parameters
        )
        return config
    }
}
