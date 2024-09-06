struct RecipientModel: Decodable, Equatable {
    let bankName, bankNumber, documentNumber, documentType: String
    let accountNumberDigit, agencyNumberDigit, agencyNumber, name: String
    let accountNumber: String
}
