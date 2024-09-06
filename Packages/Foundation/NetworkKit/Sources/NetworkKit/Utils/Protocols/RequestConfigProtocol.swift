import UIKit

public protocol RequestConfigProtocol {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any] { get set }
    var headers: [String: String] { get }
    var parametersEncoding: ParameterEncoding { get }
    var headerInterceptor: NetworkHeaderInterceptor? { get set }
    var refreshTokenEnabled: Bool { get }
    var debugMode: Bool { get }
}

extension RequestConfigProtocol {
    func createUrlRequest(with token: String? = nil) -> URLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path

        guard let url = urlComponents.url else { return nil }

        var request = URLRequest(url: url)
        request.httpMethod = "\(method)".uppercased()

        var httpBody: Data?

        if !parameters.isEmpty {
            switch parametersEncoding {
            case .url:
                urlComponents.setQueryItems(with: parameters)
                request.url = urlComponents.url
                request.setValue("application/json", forHTTPHeaderField: "Accept")
                request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")

            case .body:
                httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
                request.setValue("application/json", forHTTPHeaderField: "Accept")
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        }

        if let body = httpBody {
            request.httpBody = body
        }

        if let token = token {
            request.setValue(token, forHTTPHeaderField: "token")
        }

        request.setValue(Constants.apiKey, forHTTPHeaderField: "apikey")

        request.allHTTPHeaderFields = headers

        return request
    }
}
