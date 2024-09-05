import Foundation

public struct ResponseError: LocalizedError, Equatable, Decodable {
    public var statusCode: Int?
    public var responseErrorMessage: String
    public var httpError: NetworkError.HTTPErrors?

    public init(statusCode: Int? = nil, message: String? = nil) {
        self.statusCode = statusCode
        self.responseErrorMessage = message ?? NetworkError.unknownFailure.errorDescription ?? ""
    }

    public init(statusCode: Int? = nil, error: NetworkError = .unknownFailure) {
        self.statusCode = statusCode
        self.responseErrorMessage = error.errorDescription ?? ""
    }

    public init(statusCode: Int? = nil, error: NetworkError.HTTPErrors = .badRequest) {
        self.statusCode = statusCode
        self.responseErrorMessage = error.errorDescription ?? ""
        self.httpError = error
    }
}
