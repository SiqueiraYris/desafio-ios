import XCTest
@testable import NetworkKit

final class APIErrorMapperTests: XCTestCase {
    func test_map_whenAPIErrorIsFilled_shouldDeliversCorrectResponse() {
        let apiErrors = makeAPIErrors()
        let data = makeData(errors: apiErrors)
        let expectedResponseError = makeResponseError(errors: apiErrors)

        let receivedResponseError = APIErrorMapper.map(data, httpError: nil)

        XCTAssertEqual(receivedResponseError, expectedResponseError)
    }

    func test_map_whenAPIErrorIsEmpty_shouldDeliversCorrectResponse() {
        let expectedResponseError = makeEmptyResponseError()

        let receivedResponseError = APIErrorMapper.map(nil, httpError: nil)

        XCTAssertEqual(receivedResponseError, expectedResponseError)
    }

    // MARK: - Helpers

    private func makeAPIErrors() -> [APIError] {
        let errors = [
            APIError(
                errorCode: 404,
                errorTitle: "any-title",
                errorMessage: "any-message"
            )
        ]
        return errors
    }

    private func makeData(errors: [APIError]) -> Data? {
        do {
            let data = try JSONEncoder().encode(errors)
            return data
        } catch {
            return nil
        }
    }

    private func makeResponseError(errors: [APIError]) -> ResponseError {
        return ResponseError(statusCode: nil, apiError: errors, httpError: nil)
    }

    private func makeEmptyResponseError() -> ResponseError {
        return ResponseError(
            statusCode: nil,
            data: nil,
            apiError: nil,
            httpError: nil
        )
    }
}
