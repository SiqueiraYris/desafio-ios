import XCTest
import NetworkKit
@testable import LoginKit

final class PasswordServiceTests: XCTestCase {
    // MARK: - Tests
    
    func test_request_whenTheContentIsExpectedData_shouldReceiveSuccess() {
        let (sut, manager) = makeSUT()
        let loginModel = makeLoginModel()
        let result: PasswordServiceResult = .success(loginModel)

        manager.result = .success(makeLoginModelData(model: loginModel))
        sut.makeLogin(route: .login(document: "any-document", password: "any-password")) { _ in }
        manager.completeWithSuccess(result: result)

        XCTAssertEqual(manager.receivedMessages, [
            .setInitialToken(token: "any-token"),
            .request(result: result)
        ])
    }

    func test_request_whenTheContentIsAnyData_shouldReceiveError() {
        let (sut, manager) = makeSUT()
        let error = ResponseError.fixture()
        let result: PasswordServiceResult = .failure(error)

        manager.result = .success(makeAnyData())
        sut.makeLogin(route: .login(document: "any-document", password: "any-password")) { _ in }
        manager.completeWithError(error: error)

        XCTAssertEqual(manager.receivedMessages, [.request(result: result)])
    }

    func test_request_shouldReceiveFailure() {
        let (sut, manager) = makeSUT()
        let error = ResponseError.fixture()
        let result: PasswordServiceResult = .failure(error)

        manager.result = .failure(error)
        sut.makeLogin(route: .login(document: "any-document", password: "any-password")) { _ in }
        manager.completeWithError(error: error)

        XCTAssertEqual(manager.receivedMessages, [.request(result: result)])
    }

    // MARK: - Helpers

    private func makeSUT() -> (sut: PasswordService,
                               networkManager: NetworkManagerSpy) {
        let spy = NetworkManagerSpy()
        let sut = PasswordService(spy)

        trackForMemoryLeaks(sut)
        trackForMemoryLeaks(spy)

        return (sut, spy)
    }

    private func makeLoginModel() -> LoginModel {
        return LoginModel(token: "any-token")
    }

    private func makeLoginModelData(model: LoginModel) -> Data {
        let encoder = JSONEncoder()
        let data = try! encoder.encode(model)
        return data
    }

    private func makeAnyData() -> Data {
        return Data()
    }
}
