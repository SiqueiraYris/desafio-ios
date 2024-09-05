import Foundation

public struct DefaultResultMapper {
    public static func map<T: Decodable>(_ data: Data, to type: T.Type) -> ServiceResult {
        guard let result = try? JSONDecoder().decode(type, from: data) else {
            return .failure(ResponseError(error: .decoderFailure))
        }
        return .success(result)
    }
}
