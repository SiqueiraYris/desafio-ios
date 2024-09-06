import XCTest
import NetworkKit
@testable import StatementKit

final class ReceiptServiceTests: XCTestCase {
    // MARK: - Tests

    func test_fetch_whenTheContentIsExpectedData_shouldReceiveSuccess() {
        let (sut, networkManager) = makeSUT()
        let receiptModel = ReceiptModel.fixture()
        let result: ReceiptServiceResult = .success(receiptModel)

        networkManager.result = .success(makeReceiptModelData(model: receiptModel))

        sut.fetch(route: .getDetails(id: "any-id")) { _ in }
        networkManager.completeWithSuccess(result: result)

        XCTAssertEqual(networkManager.receivedMessages, [.request(result: result)])
    }

    func test_fetch_whenTheContentIsAnyData_shouldReceiveError() {
        let (sut, networkManager) = makeSUT()
        let error = ResponseError.fixture()
        let result: ReceiptServiceResult = .failure(error)

        networkManager.result = .success(makeAnyData())

        sut.fetch(route: .getDetails(id: "any-id")) { _ in }
        networkManager.completeWithError(error: error)

        XCTAssertEqual(networkManager.receivedMessages, [.request(result: result)])
    }

    func test_fetch_shouldReceiveFailure() {
        let (sut, networkManager) = makeSUT()
        let error = ResponseError.fixture()
        let result: ReceiptServiceResult = .failure(error)

        networkManager.result = .failure(error)

        sut.fetch(route: .getDetails(id: "any-id")) { _ in }
        networkManager.completeWithError(error: error)

        XCTAssertEqual(networkManager.receivedMessages, [.request(result: result)])
    }

    // MARK: - Helpers

    private func makeSUT() -> (sut: ReceiptService,
                               networkManager: ReceiptNetworkManagerSpy) {
        let networkSpy = ReceiptNetworkManagerSpy()
        let sut = ReceiptService(networkSpy)

        trackForMemoryLeaks(sut)
        trackForMemoryLeaks(networkSpy)

        return (sut, networkSpy)
    }

    private func makeReceiptModelData(model: ReceiptModel) -> Data {
        let encoder = JSONEncoder()
        let data = try! encoder.encode(model)
        return data
    }

    private func makeAnyData() -> Data {
        return Data()
    }
}
