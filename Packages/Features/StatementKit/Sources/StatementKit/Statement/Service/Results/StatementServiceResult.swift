import NetworkKit

enum StatementServiceResult: Equatable {
    case success(StatementModel)
    case failure(ResponseError)
}
