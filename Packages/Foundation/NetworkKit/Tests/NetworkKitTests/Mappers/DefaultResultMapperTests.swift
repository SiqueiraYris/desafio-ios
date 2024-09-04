import XCTest
@testable import NetworkKit

final class DefaultResultMapperTests: XCTestCase {
    func test_map_whenSuccess_shouldDeliversCorrectResponse() {
        let expectedObject = makeObject()
        let data = makeData(object: expectedObject)!

        let result = DefaultResultMapper.map(data, to: AnyResponse.self)

        switch result {
        case let .success(receivedObject as AnyResponse):
            XCTAssertEqual(expectedObject, receivedObject)

        default:
            XCTFail()
        }
    }

    func test_map_whenFailureWithIncorrectType_shouldDeliversCorrectResponse() {
        let object = makeObject()
        let data = makeData(object: object)!
        let expectedError = makeResponseError(data: data)

        let result = DefaultResultMapper.map(data, to: OtherResponse.self)

        switch result {
        case let .failure(receivedError):
            XCTAssertEqual(receivedError, expectedError)

        default:
            XCTFail()
        }
    }

    // MARK: - Helpers

    private func makeObject() -> AnyResponse {
        return AnyResponse(someString: "any-string")
    }

    private func makeData(object: AnyResponse) -> Data? {
        do {
            let data = try JSONEncoder().encode(object)
            return data
        } catch {
            return nil
        }
    }

    private func makeResponseError(data: Data?) -> ResponseError {
        return ResponseError(
            statusCode: nil,
            data: data,
            apiError: nil,
            httpError: nil
        )
    }
}
