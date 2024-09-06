struct StatementModel: Decodable, Equatable {
    let results: [StatementResult]
    let itemsTotal: Int
}
