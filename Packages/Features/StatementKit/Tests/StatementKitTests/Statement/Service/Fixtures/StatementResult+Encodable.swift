@testable import StatementKit

extension StatementResult: Encodable {
    enum CodingKeys: String, CodingKey {
        case items
        case date
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(items, forKey: .items)
        try container.encode(date, forKey: .date)
    }
}
