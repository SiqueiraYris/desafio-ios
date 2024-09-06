import Foundation

struct StatementItem: Decodable, Equatable {
    let id, description, label, entry: String
    let amount: Double
    let name: String
    let dateEvent: String
    let status: String
}
