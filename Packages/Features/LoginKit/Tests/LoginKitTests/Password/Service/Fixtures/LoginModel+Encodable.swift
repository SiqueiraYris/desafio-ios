import Foundation
@testable import LoginKit

extension LoginModel: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(token, forKey: .token)
    }

    enum CodingKeys: String, CodingKey {
        case token
    }
}
