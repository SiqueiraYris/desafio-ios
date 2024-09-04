import XCTest
@testable import NetworkKit

final class NetworkPinnerTests: XCTestCase {
    func test_urlSession_whenSecurityIsDisabled_shouldNotMakeSSLPinning() {
        let sut = NetworkPinner.shared
        SecurityEnabler.isSecurityEnabled = false

        let challenge = URLAuthenticationChallenge()

        sut.urlSession(makeURLSession(), didReceive: challenge) { receivedChallenge, credential in
            XCTAssertEqual(receivedChallenge, .performDefaultHandling)
            XCTAssertNil(credential)
        }
    }

    func test_urlSession_whenSecurityIsEnabledAndChallengeIsNotValid_shouldCancelRequest() {
        let sut = NetworkPinner.shared
        SecurityEnabler.isSecurityEnabled = true

        let challenge = URLAuthenticationChallenge()

        sut.urlSession(makeURLSession(), didReceive: challenge) { receivedChallenge, credential in
            XCTAssertEqual(receivedChallenge, .cancelAuthenticationChallenge)
            XCTAssertNil(credential)
        }
    }

    // MARK: - Helpers

    private func makeURLSession() -> URLSession {
        return URLSession.shared
    }
}
