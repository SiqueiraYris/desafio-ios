@testable import StatementKit

extension RecipientModel {
    static func fixture() -> RecipientModel {
        return RecipientModel(
            bankName: "any-bank-name",
            bankNumber: "any-bank-number",
            documentNumber: "any-document-number",
            documentType: "any-document-type",
            accountNumberDigit: "any-account-number-digit",
            agencyNumberDigit: "any-agency-number-digit",
            agencyNumber: "any-agency-number",
            name: "any-name",
            accountNumber: "any-account-number"
        )
    }
}
