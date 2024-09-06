import NetworkKit

enum ReceiptServiceResult {
    case success(ReceiptModel)
    case failure(ResponseError)
}
