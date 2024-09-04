import Foundation
@testable import NetworkKit

extension APIError: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(errorCode, forKey: .errorCode)
        try container.encode(errorTitle, forKey: .errorTitle)
        try container.encode(errorMessage, forKey: .errorMessage)
        try container.encode(parameters, forKey: .parameters)
    }

    enum CodingKeys: String, CodingKey {
        case errorCode, errorTitle, errorMessage, parameters
    }
}
