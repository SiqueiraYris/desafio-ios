import NetworkKit

enum ReceiptServiceResult: Equatable {
    case success(ReceiptModel)
    case failure(ResponseError)
}
