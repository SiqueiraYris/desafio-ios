import Foundation

public struct APIErrorMapper {
    static func map(_ data: Data?, httpError: NetworkError.HTTPErrors?) -> ResponseError {
        guard let errorData = data,
              let result = try? JSONDecoder().decode([APIError].self, from: errorData) else {
            return ResponseError(data: data, apiError: nil, httpError: httpError)
        }
        return ResponseError(apiError: result, httpError: httpError)
    }
}
