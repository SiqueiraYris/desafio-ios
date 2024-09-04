import XCTest
@testable import NetworkKit

final class NetworkManagerTests: XCTestCase {
    func test_isConnectionEnabled_whenDeviceIsConnect_shouldDeliversCorrectValue() {
        let (sut, _, _, _) = makeSUT()

        let isConnectionEnabled = sut.isConnectionEnabled

        XCTAssertTrue(isConnectionEnabled)
    }

    func test_isConnectionEnabled_whenDeviceIsNotConnect_shouldDeliversCorrectValue() {
        let (sut, _, _, reachabilitySpy) = makeSUT()
        reachabilitySpy.connection = .none

        let isConnectionEnabled = sut.isConnectionEnabled

        XCTAssertFalse(isConnectionEnabled)
    }

    func test_request_whenDeviceIsNotConnect_shouldDeliversInternetError() {
        let (sut, _, _, reachabilitySpy) = makeSUT()
        let route = InvalidServiceRoute.get
        reachabilitySpy.connection = .none

        sut.request(with: route.config) { result in
            switch result {
            case let .failure(responseError):
                XCTAssertEqual(
                    responseError.getError().errorMessage,
                    "Você está sem conexão com a internet."
                )

            default:
                XCTFail()
            }
        }
    }

    func test_request_whenDeviceIsConnectButURLIsIncorrect_shouldDeliversCorrectError() {
        let (sut, _, _, _) = makeSUT()
        let route = InvalidServiceRoute.get

        sut.request(with: route.config) { result in
            switch result {
            case let .failure(responseError):
                XCTAssertEqual(
                    responseError.getError().errorMessage,
                    "O serviço solicitado não está disponível."
                )

            default:
                XCTFail()
            }
        }
    }

    func test_request_whenServerSendsErrors_shouldDeliversCorrectError() {
        let (sut, urlSessionSpy, queueSpy, _) = makeSUT()
        let route = AnyServiceRoute.get
        urlSessionSpy.errorToBeReturned = NSError(domain: "any-domain", code: 1000)

        sut.request(with: route.config) { result in
            switch result {
            case let .failure(responseError):
                XCTAssertEqual(
                    responseError.getError().errorMessage,
                    "Desculpe, algo deu errado. Tente novamente ou entre em contato com nossa equipe de ajuda."
                )
                XCTAssertEqual(urlSessionSpy.receivedMessages, [.dataTask(request: URLRequest(url: URL(string: "https://any-host/any-path")!))])
                XCTAssertEqual(queueSpy.receivedMessages, [.async])

            default:
                XCTFail()
            }
        }
    }

    func test_request_whenServerDoesNotSendURLResponse_shouldDeliversCorrectError() {
        let (sut, urlSessionSpy, queueSpy, _) = makeSUT()
        let route = AnyServiceRoute.get
        urlSessionSpy.responseToBeReturned = nil

        sut.request(with: route.config) { result in
            switch result {
            case let .failure(responseError):
                XCTAssertEqual(
                    responseError.getError().errorMessage,
                    "Ocorreu um erro desconhecido"
                )
                XCTAssertEqual(urlSessionSpy.receivedMessages, [.dataTask(request: URLRequest(url: URL(string: "https://any-host/any-path")!))])
                XCTAssertEqual(queueSpy.receivedMessages, [.async])

            default:
                XCTFail()
            }
        }
    }

    func test_request_whenServerSendsStatusCode400_shouldDeliversCorrectError() {
        let (sut, urlSessionSpy, queueSpy, _) = makeSUT()
        let route = AnyServiceRoute.get
        urlSessionSpy.responseToBeReturned = makeHTTPURLResponse(statusCode: 400)

        sut.request(with: route.config) { result in
            switch result {
            case let .failure(responseError):
                XCTAssertEqual(
                    responseError.getError().errorMessage,
                    "Serviço solicitado incorreto."
                )
                XCTAssertEqual(urlSessionSpy.receivedMessages, [.dataTask(request: URLRequest(url: URL(string: "https://any-host/any-path")!))])
                XCTAssertEqual(queueSpy.receivedMessages, [.async])

            default:
                XCTFail()
            }
        }
    }

    func test_request_whenServerSendsStatusCode401_shouldDeliversCorrectError() {
        let (sut, urlSessionSpy, queueSpy, _) = makeSUT()
        let route = AnyServiceRoute.get
        urlSessionSpy.responseToBeReturned = makeHTTPURLResponse(statusCode: 401)

        sut.request(with: route.config) { result in
            switch result {
            case let .failure(responseError):
                XCTAssertEqual(
                    responseError.getError().errorMessage,
                    "Sua sessão expirou. Voce precisará fazer login de novo."
                )
                XCTAssertEqual(urlSessionSpy.receivedMessages, [.dataTask(request: URLRequest(url: URL(string: "https://any-host/any-path")!))])
                XCTAssertEqual(queueSpy.receivedMessages, [.async])

            default:
                XCTFail()
            }
        }
    }

    func test_request_whenServerSendsStatusCode403_shouldDeliversCorrectError() {
        let (sut, urlSessionSpy, queueSpy, _) = makeSUT()
        let route = AnyServiceRoute.get
        urlSessionSpy.responseToBeReturned = makeHTTPURLResponse(statusCode: 403)

        sut.request(with: route.config) { result in
            switch result {
            case let .failure(responseError):
                XCTAssertEqual(
                    responseError.getError().errorMessage,
                    "Serviço solicitado foi recusado."
                )
                XCTAssertEqual(urlSessionSpy.receivedMessages, [.dataTask(request: URLRequest(url: URL(string: "https://any-host/any-path")!))])
                XCTAssertEqual(queueSpy.receivedMessages, [.async])

            default:
                XCTFail()
            }
        }
    }

    func test_request_whenServerSendsStatusCode404_shouldDeliversCorrectError() {
        let (sut, urlSessionSpy, queueSpy, _) = makeSUT()
        let route = AnyServiceRoute.get
        urlSessionSpy.responseToBeReturned = makeHTTPURLResponse(statusCode: 404)

        sut.request(with: route.config) { result in
            switch result {
            case let .failure(responseError):
                XCTAssertEqual(
                    responseError.getError().errorMessage,
                    "Serviço solicitado não pode ser encontrado."
                )
                XCTAssertEqual(urlSessionSpy.receivedMessages, [.dataTask(request: URLRequest(url: URL(string: "https://any-host/any-path")!))])
                XCTAssertEqual(queueSpy.receivedMessages, [.async])

            default:
                XCTFail()
            }
        }
    }

    func test_request_whenServerSendsStatusCode408_shouldDeliversCorrectError() {
        let (sut, urlSessionSpy, queueSpy, _) = makeSUT()
        let route = AnyServiceRoute.get
        urlSessionSpy.responseToBeReturned = makeHTTPURLResponse(statusCode: 408)

        sut.request(with: route.config) { result in
            switch result {
            case let .failure(responseError):
                XCTAssertEqual(
                    responseError.getError().errorMessage,
                    "Serviço solicitado não recebeu resposta."
                )
                XCTAssertEqual(urlSessionSpy.receivedMessages, [.dataTask(request: URLRequest(url: URL(string: "https://any-host/any-path")!))])
                XCTAssertEqual(queueSpy.receivedMessages, [.async])

            default:
                XCTFail()
            }
        }
    }

    func test_request_whenServerSendsStatusCode422_shouldDeliversCorrectError() {
        let (sut, urlSessionSpy, queueSpy, _) = makeSUT()
        let route = AnyServiceRoute.get
        urlSessionSpy.responseToBeReturned = makeHTTPURLResponse(statusCode: 422)

        sut.request(with: route.config) { result in
            switch result {
            case let .failure(responseError):
                XCTAssertEqual(
                    responseError.getError().errorMessage,
                    "Serviço solicitado incorreto."
                )
                XCTAssertEqual(urlSessionSpy.receivedMessages, [.dataTask(request: URLRequest(url: URL(string: "https://any-host/any-path")!))])
                XCTAssertEqual(queueSpy.receivedMessages, [.async])

            default:
                XCTFail()
            }
        }
    }

    func test_request_whenServerSendsStatusCode500_shouldDeliversCorrectError() {
        let (sut, urlSessionSpy, queueSpy, _) = makeSUT()
        let route = AnyServiceRoute.get
        urlSessionSpy.responseToBeReturned = makeHTTPURLResponse(statusCode: 500)

        sut.request(with: route.config) { result in
            switch result {
            case let .failure(responseError):
                XCTAssertEqual(
                    responseError.getError().errorMessage,
                    "Estamos fazendo alguns ajustes, pedimos desculpas e logo estaremos de volta."
                )
                XCTAssertEqual(urlSessionSpy.receivedMessages, [.dataTask(request: URLRequest(url: URL(string: "https://any-host/any-path")!))])
                XCTAssertEqual(queueSpy.receivedMessages, [.async])

            default:
                XCTFail()
            }
        }
    }

    func test_request_whenServerSendsOtherErrorStatusCode_shouldDeliversCorrectError() {
        let (sut, urlSessionSpy, queueSpy, _) = makeSUT()
        let route = AnyServiceRoute.get
        urlSessionSpy.responseToBeReturned = makeHTTPURLResponse(statusCode: 600)

        sut.request(with: route.config) { result in
            switch result {
            case let .failure(responseError):
                XCTAssertEqual(
                    responseError.getError().errorMessage,
                    "Desculpe, algo deu errado. Tente novamente ou entre em contato com nossa equipe de ajuda."
                )
                XCTAssertEqual(urlSessionSpy.receivedMessages, [.dataTask(request: URLRequest(url: URL(string: "https://any-host/any-path")!))])
                XCTAssertEqual(queueSpy.receivedMessages, [.async])

            default:
                XCTFail()
            }
        }
    }

    func test_request_whenServerDoesNotSendData_shouldDeliversCorrectError() {
        let (sut, urlSessionSpy, queueSpy, _) = makeSUT()
        let route = AnyServiceRoute.get
        urlSessionSpy.responseToBeReturned = makeHTTPURLResponse()

        sut.request(with: route.config) { result in
            switch result {
            case let .failure(responseError):
                XCTAssertEqual(
                    responseError.getError().errorMessage,
                    "Ocorreu um erro desconhecido"
                )
                XCTAssertEqual(urlSessionSpy.receivedMessages, [.dataTask(request: URLRequest(url: URL(string: "https://any-host/any-path")!))])
                XCTAssertEqual(queueSpy.receivedMessages, [.async])

            default:
                XCTFail()
            }
        }
    }

    func test_request_whenItHasSuccess_shouldDeliversCorrectResponse() {
        let (sut, urlSessionSpy, queueSpy, _) = makeSUT()
        let expectedData = Data()
        let route = AnyServiceRoute.get
        urlSessionSpy.responseToBeReturned = makeHTTPURLResponse()
        urlSessionSpy.dataToBeReturned = expectedData

        sut.request(with: route.config) { result in
            switch result {
            case let .success(receivedData):
                XCTAssertEqual(receivedData, expectedData)
                XCTAssertEqual(urlSessionSpy.receivedMessages, [.dataTask(request: URLRequest(url: URL(string: "https://any-host/any-path")!))])
                XCTAssertEqual(queueSpy.receivedMessages, [.async])

            default:
                XCTFail()
            }
        }
    }

    // MARK: - Helpers

    private func makeSUT() -> (
        sut: NetworkManager,
        urlSessionSpy: URLSessionSpy,
        queueSpy: DispatchQueueSpy,
        reachabilitySpy: ReachabilitySpy
    ) {
        let urlSessionSpy = URLSessionSpy()
        let queueSpy = DispatchQueueSpy()
        let reachabilitySpy = ReachabilitySpy()

        let sut = NetworkManager(
            session: urlSessionSpy,
            queue: queueSpy,
            reachability: reachabilitySpy
        )

        trackForMemoryLeaks(sut)
        trackForMemoryLeaks(urlSessionSpy)
        trackForMemoryLeaks(queueSpy)
        trackForMemoryLeaks(reachabilitySpy)

        return (sut, urlSessionSpy, queueSpy, reachabilitySpy)
    }

    private func makeHTTPURLResponse(statusCode: Int = 200) -> HTTPURLResponse? {
        return HTTPURLResponse(
            url: URL(string: "https://any-host/any-path")!,
            statusCode: statusCode,
            httpVersion: nil,
            headerFields: nil
        )
    }
}
