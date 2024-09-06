@testable import StatementKit

extension StatementItem: Encodable {
    enum CodingKeys: String, CodingKey {
        case id
        case description
        case label
        case entry
        case amount
        case name
        case dateEvent
        case status
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(description, forKey: .description)
        try container.encode(label, forKey: .label)
        try container.encode(entry, forKey: .entry)
        try container.encode(amount, forKey: .amount)
        try container.encode(name, forKey: .name)
        try container.encode(dateEvent, forKey: .dateEvent)
        try container.encode(status, forKey: .status)
    }
}
