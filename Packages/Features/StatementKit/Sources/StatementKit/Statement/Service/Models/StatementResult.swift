struct StatementResult: Decodable, Equatable {
    let items: [StatementItem]
    let date: String
}
