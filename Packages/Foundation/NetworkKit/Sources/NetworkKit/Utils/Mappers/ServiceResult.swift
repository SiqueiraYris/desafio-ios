public enum ServiceResult {
    case success(Decodable)
    case failure(ResponseError)
}
