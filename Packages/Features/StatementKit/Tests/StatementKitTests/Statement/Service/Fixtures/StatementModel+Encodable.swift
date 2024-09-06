@testable import StatementKit

extension StatementModel: Encodable {
    enum CodingKeys: String, CodingKey {
        case results
        case itemsTotal
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(results, forKey: .results)
        try container.encode(itemsTotal, forKey: .itemsTotal)
    }
}
