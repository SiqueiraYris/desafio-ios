import Foundation

public enum ResponseResult {
    case success(Data)
    case failure(ResponseError)
}

public protocol NetworkManagerProtocol {
    static var shared: NetworkManager { get }

    func request(with config: RequestConfigProtocol,
                 completion: @escaping (ResponseResult) -> Void)
}
