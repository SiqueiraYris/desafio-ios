struct ReceiptModel: Decodable, Equatable {
    let description, label: String
    let amount: Double
    let counterPartyName, id: String
    let dateEvent: String
    let recipient, sender: RecipientModel
    let status: String
}
