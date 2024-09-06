@testable import StatementKit

extension ReceiptModel: Encodable {
    enum CodingKeys: String, CodingKey {
        case description
        case label
        case amount
        case counterPartyName
        case id
        case dateEvent
        case recipient
        case sender
        case status
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(description, forKey: .description)
        try container.encode(label, forKey: .label)
        try container.encode(amount, forKey: .amount)
        try container.encode(counterPartyName, forKey: .counterPartyName)
        try container.encode(id, forKey: .id)
        try container.encode(dateEvent, forKey: .dateEvent)
        try container.encode(recipient, forKey: .recipient)
        try container.encode(sender, forKey: .sender)
        try container.encode(status, forKey: .status)
    }
}
