import Foundation

/// This error model is delivered when the application receives some http error
///[
///    {
///        "errorCode": 1,
///        "errorTitle": "any-title",
///        "errorMessage": "any-message",
///        "parameters": {
///            "parameter1": "abc"
///        }
///    },
///    {
///        "errorCode": 2,
///        "errorTitle": "any-title",
///        "errorMessage": "any-message",
///        "parameters": {
///            "parameter1": "abc"
///        }
///    },
///    {
///        "errorCode": 3,
///        "errorTitle": "any-title",
///        "errorMessage": "any-message",
///        "parameters": null
///    }
///]
public struct APIError: Decodable, Equatable {
    public let errorCode: Int?
    public let errorTitle: String
    public let errorMessage: String
    public let parameters: [String: String]?

    public init(
        errorCode: Int?,
        errorTitle: String,
        errorMessage: String,
        parameters: [String: String]? = nil
    ) {
        self.errorCode = errorCode
        self.errorTitle = errorTitle
        self.errorMessage = errorMessage
        self.parameters = parameters
    }
}
