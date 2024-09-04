import Foundation

public struct ResponseError: LocalizedError, Equatable, Decodable {
    public var statusCode: Int?
    public var data: Data?
    public var responseErrorMessage: String
    public var apiError: [APIError]?
    public var httpError: NetworkError.HTTPErrors?

    public static let defaultErrorMessage = NetworkError.unknownFailure.errorDescription ?? "ERROR"

    public init(statusCode: Int? = nil, data: Data? = nil, defaultError: Error) {
        self.statusCode = statusCode
        self.data = data
        self.responseErrorMessage = defaultError.localizedDescription

        guard let data = data else { return }
        self.apiError = try? JSONDecoder().decode([APIError].self, from: data)
    }

    public init(statusCode: Int? = nil, data: Data? = nil, defaultError: NetworkError.HTTPErrors = .badRequest) {
        self.statusCode = statusCode
        self.data = data
        self.responseErrorMessage = defaultError.errorDescription ?? ResponseError.defaultErrorMessage

        guard let data = data else { return }
        self.apiError = try? JSONDecoder().decode([APIError].self, from: data)
    }

    public init(statusCode: Int? = nil, data: Data? = nil, defaultError: NetworkError = .decoderFailure) {
        self.statusCode = statusCode
        self.data = data
        self.responseErrorMessage = defaultError.errorDescription ?? ResponseError.defaultErrorMessage
        self.apiError = nil

        guard let data = data else { return }
        self.apiError = try? JSONDecoder().decode([APIError].self, from: data)
    }

    public init(statusCode: Int? = nil, data: Data? = nil, defaultError: NetworkErrorProtocol = NetworkError.decoderFailure) {
        self.statusCode = statusCode
        self.data = data
        self.responseErrorMessage = defaultError.errorDescription ?? ResponseError.defaultErrorMessage
        self.apiError = nil

        guard let data = data else { return }
        self.apiError = try? JSONDecoder().decode([APIError].self, from: data)
    }

    public init(statusCode: Int? = nil,
                data: Data? = nil,
                message: String = ResponseError.defaultErrorMessage,
                apiError: [APIError]? = nil,
                httpError: NetworkError.HTTPErrors? = nil) {
        self.statusCode = statusCode
        self.data = data
        self.responseErrorMessage = message
        self.apiError = apiError
        self.httpError = httpError
    }

    public func getError() -> APIError {
        let title = apiError?.first?.errorTitle ?? "Ops!"
        let message = apiError?.first?.errorMessage ?? httpError?.errorDescription ?? responseErrorMessage

        return APIError(
            errorCode: apiError?.first?.errorCode,
            errorTitle: title,
            errorMessage: message,
            parameters: apiError?.first?.parameters
        )
    }
}
