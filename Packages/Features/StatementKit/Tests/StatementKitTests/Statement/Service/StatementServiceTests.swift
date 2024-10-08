import XCTest
import NetworkKit
@testable import StatementKit

final class StatementServiceTests: XCTestCase {
    // MARK: - Tests

    func test_fetch_whenTheContentIsExpectedData_shouldReceiveSuccess() {
        let (sut, networkManager) = makeSUT()
        let statementModel = StatementModel.fixture()
        let result: StatementServiceResult = .success(statementModel)

        networkManager.result = .success(makeStatementModelData(model: statementModel))

        sut.fetch(route: .getTransactions) { _ in }
        networkManager.completeWithSuccess(result: result)

        XCTAssertEqual(networkManager.receivedMessages, [.request(result: result)])
    }

    func test_fetch_whenTheContentIsAnyData_shouldReceiveError() {
        let (sut, networkManager) = makeSUT()
        let error = ResponseError.fixture()
        let result: StatementServiceResult = .failure(error)

        networkManager.result = .success(makeAnyData())

        sut.fetch(route: .getTransactions) { _ in }
        networkManager.completeWithError(error: error)

        XCTAssertEqual(networkManager.receivedMessages, [.request(result: result)])
    }

    func test_fetch_shouldReceiveFailure() {
        let (sut, networkManager) = makeSUT()
        let error = ResponseError.fixture()
        let result: StatementServiceResult = .failure(error)

        networkManager.result = .failure(error)

        sut.fetch(route: .getTransactions) { _ in }
        networkManager.completeWithError(error: error)

        XCTAssertEqual(networkManager.receivedMessages, [.request(result: result)])
    }

    // MARK: - Helpers

    private func makeSUT() -> (sut: StatementService,
                               networkManager: NetworkManagerSpy) {
        let networkSpy = NetworkManagerSpy()
        let sut = StatementService(networkSpy)

        trackForMemoryLeaks(sut)
        trackForMemoryLeaks(networkSpy)

        return (sut, networkSpy)
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
