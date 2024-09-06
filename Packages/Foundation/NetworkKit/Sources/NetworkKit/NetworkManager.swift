import Foundation

public final class NetworkManager: NetworkManagerProtocol {
    private let session: URLSessionProtocol
    private let queue: DispatchQueueProtocol
    private let tokenManager: TokenManagerProtocol

    public static var shared = NetworkManager(tokenManager: TokenManager.shared)

    public convenience init(urlSession: URLSessionProtocol, tokenManager: TokenManagerProtocol) {
        self.init(session: urlSession, tokenManager: tokenManager)
    }

    init(
        session: URLSessionProtocol = URLSession.shared,
        queue: DispatchQueueProtocol = DispatchQueue.main,
        tokenManager: TokenManagerProtocol
    ) {
        self.session = session
        self.queue = queue
        self.tokenManager = tokenManager
    }

    public func request(with config: RequestConfigProtocol, completion: @escaping (ResponseResult) -> Void) {
        if config.refreshTokenEnabled {
            tokenManager.getToken { [weak self] token in
                self?.makeRequest(with: config, and: token, completion: completion)
            }
        } else {
            makeRequest(with: config, completion: completion)
        }
    }

    public func setInitialToken(_ token: String) {
        TokenManager.shared.setInitialToken(token)
    }

    private func makeRequest(
        with config: RequestConfigProtocol,
        and token: String? = nil,
        completion: @escaping (ResponseResult) -> Void
    ) {
        guard let urlRequest = config.createUrlRequest(with: token) else {
            completion(.failure(ResponseError(error: .badRequest)))
            return
        }

        curl(from: urlRequest, debug: config.debugMode)

        let task = session.dataTask(with: urlRequest) { data, response, error in
            self.queue.async {
                do {
                    if let nsError = error as NSError? {
                        try ResponseMapper.map(nsError)
                    }

                    guard let httpURLResponse = response as? HTTPURLResponse else { throw NetworkError.unknownFailure }
                    try ResponseMapper.map(httpURLResponse.statusCode)

                    config.headerInterceptor?.intercept(headers: httpURLResponse.allHeaderFields)

                    guard let data = data else {
                        throw NetworkError.noData
                    }

                    self.checkPrintDebugData(title: "Decoding",
                                             debug: config.debugMode,
                                             url: urlRequest.url?.absoluteString,
                                             data: data,
                                             curl: urlRequest.curlString)

                    completion(.success(data))
                } catch let error as NetworkError {
                    self.genericCatchError(urlRequest: urlRequest, data: data, error: error, config: config, completion: completion)
                } catch let error as NetworkError.HTTPErrors {
                    completion(.failure(ResponseError(error: error)))
                } catch {
                    self.genericCatchError(urlRequest: urlRequest, data: data, error: NetworkError.unknownFailure, config: config, completion: completion)
                }
            }
        }
        task.resume()
    }
}

extension NetworkManager {
    private func curl(from urlRequest: URLRequest, debug: Bool) {
        if debug {
            print("---------------------------------------------------------------")
            print("---------------------------------------------------------------")
            guard let url = urlRequest.url else { return }
            var baseCommand = #"curl "\#(url.absoluteString)""#
            if urlRequest.httpMethod == "HEAD" {
                baseCommand += " --head"
            }
            
            var command = [baseCommand]
            if let method = urlRequest.httpMethod, method != "GET" && method != "HEAD" {
                command.append("-X \(method)")
            }
            
            if let headers = urlRequest.allHTTPHeaderFields {
                for (key, value) in headers where key != "Cookie" {
                    command.append("-H '\(key): \(value)'")
                }
            }
            
            if let data = urlRequest.httpBody, let body = String(data: data, encoding: .utf8) {
                command.append("-d '\(body)'")
            }
            
            print(command.joined(separator: " \\\n\t"))
        }
    }
    
    private func checkPrintDebugData(title: String, debug: Bool, url: String?, data: Data?, curl: String?) {
        if debug {
            printDebugData(title: title, url: url, data: data, curl: curl)
        }
    }

    private func genericCatchError<R>(urlRequest: URLRequest,
                                      data: Data?,
                                      error: R,
                                      config: RequestConfigProtocol,
                                      completion: @escaping (ResponseResult) -> Void) where R: NetworkErrorProtocol {
        if config.debugMode {
            printDebugData(title: String(describing: R.self),
                           url: urlRequest.url?.absoluteString,
                           data: data,
                           curl: urlRequest.curlString)
        }
        completion(.failure(ResponseError(
            statusCode: error.code,
            message: error.errorDescription
        )))
    }

    /// With this code you can get curl and put this code in postman to test
    private func printDebugData(title: String, url: String?, data: Data?, curl: String?) {
        print("---------------------------------------------------------------")
        print("🔬 - DEBUG MODE ON FOR: \(title) - 🔬")
        print("📡 URL: \(url ?? "No URL passed")")
        print(data?.toString() ?? "No Data passed")
        print(curl ?? "No curl command passed")
        print("---------------------------------------------------------------")
    }
}
