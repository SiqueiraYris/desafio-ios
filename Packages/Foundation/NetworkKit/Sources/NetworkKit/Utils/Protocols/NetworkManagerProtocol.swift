import Foundation

public enum ResponseResult {
    case success(Data)
    case failure(ResponseError)
}

public protocol NetworkManagerProtocol {
    func request(with config: RequestConfigProtocol,
                 completion: @escaping (ResponseResult) -> Void)
    func setInitialToken(_ token: String)
}
