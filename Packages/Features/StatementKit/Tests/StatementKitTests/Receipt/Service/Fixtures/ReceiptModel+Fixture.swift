@testable import StatementKit

extension ReceiptModel {
    static func fixture() -> ReceiptModel {
        return ReceiptModel(
            description: "any-description",
            label: "any-label",
            amount: 1000.0,
            counterPartyName: "any-counter-party-name",
            id: "any-id",
            dateEvent: "any-date-event",
            recipient: .fixture(),
            sender: .fixture(),
            status: "any-status"
        )
    }
}
