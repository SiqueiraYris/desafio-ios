@testable import StatementKit

extension StatementModel {
    static func fixture() -> StatementModel {
        return StatementModel(
            results: [.init(
                items: [.init(
                    id: "any-id",
                    description: "any-description",
                    label: "any-label",
                    entry: "any-entry",
                    amount: 1000,
                    name: "any-name",
                    dateEvent: "any-date-event",
                    status: "any-status"
                )]
                , date: "any-date"
            )],
            itemsTotal: 1
        )
    }
}
