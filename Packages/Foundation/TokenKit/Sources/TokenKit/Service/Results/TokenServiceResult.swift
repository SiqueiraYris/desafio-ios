import NetworkKit

enum TokenServiceResult: Equatable {
    case success(TokenModel)
    case failure(ResponseError)
}
