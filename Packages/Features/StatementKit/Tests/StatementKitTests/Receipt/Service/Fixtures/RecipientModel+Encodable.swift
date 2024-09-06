@testable import StatementKit

extension RecipientModel: Encodable {
    enum CodingKeys: String, CodingKey {
        case bankName
        case bankNumber
        case documentNumber
        case documentType
        case accountNumberDigit
        case agencyNumberDigit
        case agencyNumber
        case name
        case accountNumber
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(bankName, forKey: .bankName)
        try container.encode(bankNumber, forKey: .bankNumber)
        try container.encode(documentNumber, forKey: .documentNumber)
        try container.encode(documentType, forKey: .documentType)
        try container.encode(accountNumberDigit, forKey: .accountNumberDigit)
        try container.encode(agencyNumberDigit, forKey: .agencyNumberDigit)
        try container.encode(agencyNumber, forKey: .agencyNumber)
        try container.encode(name, forKey: .name)
        try container.encode(accountNumber, forKey: .accountNumber)
    }
}
