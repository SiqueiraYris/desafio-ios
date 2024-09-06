import XCTest
import NetworkKit
import TokenKit
@testable import StatementKit

final class StatementServiceTests: XCTestCase {
    // MARK: - Tests

    func test_fetch_whenTheContentIsExpectedData_shouldReceiveSuccess() {
        let (sut, networkManager, tokenManager) = makeSUT()
        let statementModel = StatementModel.fixture()
        let result: StatementServiceResult = .success(statementModel)

        networkManager.result = .success(makeStatementModelData(model: statementModel))
        tokenManager.tokenToBeReturned = "any-valid-token"

        sut.fetch(route: .getTransactions) { _ in }
        networkManager.completeWithSuccess(result: result)

        XCTAssertEqual(networkManager.receivedMessages, [.request(result: result)])
        XCTAssertEqual(tokenManager.receivedMessages, [.getToken])
    }

    func test_fetch_whenTheContentIsAnyData_shouldReceiveError() {
        let (sut, networkManager, tokenManager) = makeSUT()
        let error = ResponseError.fixture()
        let result: StatementServiceResult = .failure(error)

        networkManager.result = .success(makeAnyData())
        tokenManager.tokenToBeReturned = "any-valid-token"

        sut.fetch(route: .getTransactions) { _ in }
        networkManager.completeWithError(error: error)

        XCTAssertEqual(networkManager.receivedMessages, [.request(result: result)])
        XCTAssertEqual(tokenManager.receivedMessages, [.getToken])
    }

    func test_fetch_shouldReceiveFailure() {
        let (sut, networkManager, tokenManager) = makeSUT()
        let error = ResponseError.fixture()
        let result: StatementServiceResult = .failure(error)

        networkManager.result = .failure(error)
        tokenManager.tokenToBeReturned = "any-valid-token"

        sut.fetch(route: .getTransactions) { _ in }
        networkManager.completeWithError(error: error)

        XCTAssertEqual(networkManager.receivedMessages, [.request(result: result)])
        XCTAssertEqual(tokenManager.receivedMessages, [.getToken])
    }

    // MARK: - Helpers

    private func makeSUT() -> (sut: StatementService,
                               networkManager: NetworkManagerSpy,
                               tokenManager: TokenManagerSpy) {
        let networkSpy = NetworkManagerSpy()
        let tokenSpy = TokenManagerSpy()
        let sut = StatementService(networkSpy, tokenManager: tokenSpy)

        trackForMemoryLeaks(sut)
        trackForMemoryLeaks(networkSpy)
        trackForMemoryLeaks(tokenSpy)

        return (sut, networkSpy, tokenSpy)
    }

    private func makeStatementModelData(model: StatementModel) -> Data {
        let encoder = JSONEncoder()
        let data = try! encoder.encode(model)
        return data
    }

    private func makeAnyData() -> Data {
        return Data()
    }
}
