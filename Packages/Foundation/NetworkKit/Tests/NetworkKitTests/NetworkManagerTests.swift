import XCTest
@testable import NetworkKit

final class NetworkManagerTests: XCTestCase {
    func test_request_whenServerSendsErrors_shouldDeliversCorrectError() {
        let (sut, urlSessionSpy, queueSpy, tokenManagerSpy) = makeSUT()
        let route = AnyServiceRoute.get
        urlSessionSpy.errorToBeReturned = NSError(domain: "any-domain", code: 1000)

        sut.request(with: route.config) { result in
            switch result {
            case let .failure(responseError):
                XCTAssertEqual(
                    responseError.responseErrorMessage,
                    "Desculpe, algo deu errado. Tente novamente ou entre em contato com nossa equipe de ajuda."
                )
                XCTAssertEqual(queueSpy.receivedMessages, [.async])
                XCTAssertEqual(tokenManagerSpy.receivedMessages, [])

            default:
                XCTFail()
            }
        }
    }

    func test_request_whenServerSendsErrorsAndShouldRefreshToken_shouldDeliversCorrectError() {
        let (sut, urlSessionSpy, queueSpy, tokenManagerSpy) = makeSUT()
        let route = RefreshTokenServiceRoute.get
        urlSessionSpy.errorToBeReturned = NSError(domain: "any-domain", code: 1000)

        sut.request(with: route.config) { result in
            switch result {
            case let .failure(responseError):
                XCTAssertEqual(
                    responseError.responseErrorMessage,
                    "Desculpe, algo deu errado. Tente novamente ou entre em contato com nossa equipe de ajuda."
                )
                XCTAssertEqual(queueSpy.receivedMessages, [.async])
                XCTAssertEqual(tokenManagerSpy.receivedMessages, [.getToken])

            default:
                XCTFail()
            }
        }
    }

    func test_request_whenServerDoesNotSendURLResponse_shouldDeliversCorrectError() {
        let (sut, urlSessionSpy, queueSpy, tokenManagerSpy) = makeSUT()
        let route = AnyServiceRoute.get
        urlSessionSpy.responseToBeReturned = nil

        sut.request(with: route.config) { result in
            switch result {
            case let .failure(responseError):
                XCTAssertEqual(
                    responseError.responseErrorMessage,
                    "Ocorreu um erro desconhecido"
                )
                XCTAssertEqual(queueSpy.receivedMessages, [.async])
                XCTAssertEqual(tokenManagerSpy.receivedMessages, [])

            default:
                XCTFail()
            }
        }
    }

    func test_request_whenServerDoesNotSendURLResponseAndShouldRefreshToken_shouldDeliversCorrectError() {
        let (sut, urlSessionSpy, queueSpy, tokenManagerSpy) = makeSUT()
        let route = RefreshTokenServiceRoute.get
        urlSessionSpy.responseToBeReturned = nil

        sut.request(with: route.config) { result in
            switch result {
            case let .failure(responseError):
                XCTAssertEqual(
                    responseError.responseErrorMessage,
                    "Ocorreu um erro desconhecido"
                )
                XCTAssertEqual(queueSpy.receivedMessages, [.async])
                XCTAssertEqual(tokenManagerSpy.receivedMessages, [.getToken])

            default:
                XCTFail()
            }
        }
    }

    func test_request_whenServerSendsStatusCode400_shouldDeliversCorrectError() {
        let (sut, urlSessionSpy, queueSpy, tokenManagerSpy) = makeSUT()
        let route = AnyServiceRoute.get
        urlSessionSpy.responseToBeReturned = makeHTTPURLResponse(statusCode: 400)

        sut.request(with: route.config) { result in
            switch result {
            case let .failure(responseError):
                XCTAssertEqual(
                    responseError.responseErrorMessage,
                    "Serviço solicitado incorreto."
                )
                XCTAssertEqual(queueSpy.receivedMessages, [.async])
                XCTAssertEqual(tokenManagerSpy.receivedMessages, [])

            default:
                XCTFail()
            }
        }
    }

    func test_request_whenServerSendsStatusCode400AndShouldRefreshToken_shouldDeliversCorrectError() {
        let (sut, urlSessionSpy, queueSpy, tokenManagerSpy) = makeSUT()
        let route = RefreshTokenServiceRoute.get
        urlSessionSpy.responseToBeReturned = makeHTTPURLResponse(statusCode: 400)

        sut.request(with: route.config) { result in
            switch result {
            case let .failure(responseError):
                XCTAssertEqual(
                    responseError.responseErrorMessage,
                    "Serviço solicitado incorreto."
                )
                XCTAssertEqual(queueSpy.receivedMessages, [.async])
                XCTAssertEqual(tokenManagerSpy.receivedMessages, [.getToken])

            default:
                XCTFail()
            }
        }
    }

    func test_request_whenServerSendsStatusCode401_shouldDeliversCorrectError() {
        let (sut, urlSessionSpy, queueSpy, tokenManagerSpy) = makeSUT()
        let route = AnyServiceRoute.get
        urlSessionSpy.responseToBeReturned = makeHTTPURLResponse(statusCode: 401)

        sut.request(with: route.config) { result in
            switch result {
            case let .failure(responseError):
                XCTAssertEqual(
                    responseError.responseErrorMessage,
                    "Sua sessão expirou. Voce precisará fazer login de novo."
                )
                XCTAssertEqual(queueSpy.receivedMessages, [.async])
                XCTAssertEqual(tokenManagerSpy.receivedMessages, [])

            default:
                XCTFail()
            }
        }
    }

    func test_request_whenServerSendsStatusCode403_shouldDeliversCorrectError() {
        let (sut, urlSessionSpy, queueSpy, tokenManagerSpy) = makeSUT()
        let route = AnyServiceRoute.get
        urlSessionSpy.responseToBeReturned = makeHTTPURLResponse(statusCode: 403)

        sut.request(with: route.config) { result in
            switch result {
            case let .failure(responseError):
                XCTAssertEqual(
                    responseError.responseErrorMessage,
                    "Serviço solicitado foi recusado."
                )
                XCTAssertEqual(queueSpy.receivedMessages, [.async])
                XCTAssertEqual(tokenManagerSpy.receivedMessages, [])

            default:
                XCTFail()
            }
        }
    }

    func test_request_whenServerSendsStatusCode403AndShouldRefreshToken_shouldDeliversCorrectError() {
        let (sut, urlSessionSpy, queueSpy, tokenManagerSpy) = makeSUT()
        let route = RefreshTokenServiceRoute.get
        urlSessionSpy.responseToBeReturned = makeHTTPURLResponse(statusCode: 403)

        sut.request(with: route.config) { result in
            switch result {
            case let .failure(responseError):
                XCTAssertEqual(
                    responseError.responseErrorMessage,
                    "Serviço solicitado foi recusado."
                )
                XCTAssertEqual(queueSpy.receivedMessages, [.async])
                XCTAssertEqual(tokenManagerSpy.receivedMessages, [.getToken])

            default:
                XCTFail()
            }
        }
    }

    func test_request_whenServerSendsStatusCode404_shouldDeliversCorrectError() {
        let (sut, urlSessionSpy, queueSpy, tokenManagerSpy) = makeSUT()
        let route = AnyServiceRoute.get
        urlSessionSpy.responseToBeReturned = makeHTTPURLResponse(statusCode: 404)

        sut.request(with: route.config) { result in
            switch result {
            case let .failure(responseError):
                XCTAssertEqual(
                    responseError.responseErrorMessage,
                    "Serviço solicitado não pode ser encontrado."
                )
                XCTAssertEqual(queueSpy.receivedMessages, [.async])
                XCTAssertEqual(tokenManagerSpy.receivedMessages, [])

            default:
                XCTFail()
            }
        }
    }

    func test_request_whenServerSendsStatusCode404AndShouldRefreshToken_shouldDeliversCorrectError() {
        let (sut, urlSessionSpy, queueSpy, tokenManagerSpy) = makeSUT()
        let route = RefreshTokenServiceRoute.get
        urlSessionSpy.responseToBeReturned = makeHTTPURLResponse(statusCode: 404)

        sut.request(with: route.config) { result in
            switch result {
            case let .failure(responseError):
                XCTAssertEqual(
                    responseError.responseErrorMessage,
                    "Serviço solicitado não pode ser encontrado."
                )
                XCTAssertEqual(queueSpy.receivedMessages, [.async])
                XCTAssertEqual(tokenManagerSpy.receivedMessages, [.getToken])

            default:
                XCTFail()
            }
        }
    }

    func test_request_whenServerSendsStatusCode408_shouldDeliversCorrectError() {
        let (sut, urlSessionSpy, queueSpy, tokenManagerSpy) = makeSUT()
        let route = AnyServiceRoute.get
        urlSessionSpy.responseToBeReturned = makeHTTPURLResponse(statusCode: 408)

        sut.request(with: route.config) { result in
            switch result {
            case let .failure(responseError):
                XCTAssertEqual(
                    responseError.responseErrorMessage,
                    "Serviço solicitado não recebeu resposta."
                )
                XCTAssertEqual(queueSpy.receivedMessages, [.async])
                XCTAssertEqual(tokenManagerSpy.receivedMessages, [])

            default:
                XCTFail()
            }
        }
    }

    func test_request_whenServerSendsStatusCode408AndShouldRefreshToken_shouldDeliversCorrectError() {
        let (sut, urlSessionSpy, queueSpy, tokenManagerSpy) = makeSUT()
        let route = RefreshTokenServiceRoute.get
        urlSessionSpy.responseToBeReturned = makeHTTPURLResponse(statusCode: 408)

        sut.request(with: route.config) { result in
            switch result {
            case let .failure(responseError):
                XCTAssertEqual(
                    responseError.responseErrorMessage,
                    "Serviço solicitado não recebeu resposta."
                )
                XCTAssertEqual(queueSpy.receivedMessages, [.async])
                XCTAssertEqual(tokenManagerSpy.receivedMessages, [.getToken])

            default:
                XCTFail()
            }
        }
    }

    func test_request_whenServerSendsStatusCode422_shouldDeliversCorrectError() {
        let (sut, urlSessionSpy, queueSpy, tokenManagerSpy) = makeSUT()
        let route = AnyServiceRoute.get
        urlSessionSpy.responseToBeReturned = makeHTTPURLResponse(statusCode: 422)

        sut.request(with: route.config) { result in
            switch result {
            case let .failure(responseError):
                XCTAssertEqual(
                    responseError.responseErrorMessage,
                    "Serviço solicitado incorreto."
                )
                XCTAssertEqual(queueSpy.receivedMessages, [.async])
                XCTAssertEqual(tokenManagerSpy.receivedMessages, [])

            default:
                XCTFail()
            }
        }
    }

    func test_request_whenServerSendsStatusCode422AndShouldRefreshToken_shouldDeliversCorrectError() {
        let (sut, urlSessionSpy, queueSpy, tokenManagerSpy) = makeSUT()
        let route = RefreshTokenServiceRoute.get
        urlSessionSpy.responseToBeReturned = makeHTTPURLResponse(statusCode: 422)

        sut.request(with: route.config) { result in
            switch result {
            case let .failure(responseError):
                XCTAssertEqual(
                    responseError.responseErrorMessage,
                    "Serviço solicitado incorreto."
                )
                XCTAssertEqual(queueSpy.receivedMessages, [.async])
                XCTAssertEqual(tokenManagerSpy.receivedMessages, [.getToken])

            default:
                XCTFail()
            }
        }
    }

    func test_request_whenServerSendsStatusCode500_shouldDeliversCorrectError() {
        let (sut, urlSessionSpy, queueSpy, tokenManagerSpy) = makeSUT()
        let route = AnyServiceRoute.get
        urlSessionSpy.responseToBeReturned = makeHTTPURLResponse(statusCode: 500)

        sut.request(with: route.config) { result in
            switch result {
            case let .failure(responseError):
                XCTAssertEqual(
                    responseError.responseErrorMessage,
                    "Estamos fazendo alguns ajustes, pedimos desculpas e logo estaremos de volta."
                )
                XCTAssertEqual(queueSpy.receivedMessages, [.async])
                XCTAssertEqual(tokenManagerSpy.receivedMessages, [])

            default:
                XCTFail()
            }
        }
    }

    func test_request_whenServerSendsStatusCode500AndShouldRefreshToken_shouldDeliversCorrectError() {
        let (sut, urlSessionSpy, queueSpy, tokenManagerSpy) = makeSUT()
        let route = RefreshTokenServiceRoute.get
        urlSessionSpy.responseToBeReturned = makeHTTPURLResponse(statusCode: 500)

        sut.request(with: route.config) { result in
            switch result {
            case let .failure(responseError):
                XCTAssertEqual(
                    responseError.responseErrorMessage,
                    "Estamos fazendo alguns ajustes, pedimos desculpas e logo estaremos de volta."
                )
                XCTAssertEqual(queueSpy.receivedMessages, [.async])
                XCTAssertEqual(tokenManagerSpy.receivedMessages, [.getToken])

            default:
                XCTFail()
            }
        }
    }

    func test_request_whenServerSendsOtherErrorStatusCode_shouldDeliversCorrectError() {
        let (sut, urlSessionSpy, queueSpy, tokenManagerSpy) = makeSUT()
        let route = AnyServiceRoute.get
        urlSessionSpy.responseToBeReturned = makeHTTPURLResponse(statusCode: 600)

        sut.request(with: route.config) { result in
            switch result {
            case let .failure(responseError):
                XCTAssertEqual(
                    responseError.responseErrorMessage,
                    "Desculpe, algo deu errado. Tente novamente ou entre em contato com nossa equipe de ajuda."
                )
                XCTAssertEqual(queueSpy.receivedMessages, [.async])
                XCTAssertEqual(tokenManagerSpy.receivedMessages, [])

            default:
                XCTFail()
            }
        }
    }

    func test_request_whenServerSendsOtherErrorStatusCodeAndShouldRefreshToken_shouldDeliversCorrectError() {
        let (sut, urlSessionSpy, queueSpy, tokenManagerSpy) = makeSUT()
        let route = RefreshTokenServiceRoute.get
        urlSessionSpy.responseToBeReturned = makeHTTPURLResponse(statusCode: 600)

        sut.request(with: route.config) { result in
            switch result {
            case let .failure(responseError):
                XCTAssertEqual(
                    responseError.responseErrorMessage,
                    "Desculpe, algo deu errado. Tente novamente ou entre em contato com nossa equipe de ajuda."
                )
                XCTAssertEqual(queueSpy.receivedMessages, [.async])
                XCTAssertEqual(tokenManagerSpy.receivedMessages, [.getToken])

            default:
                XCTFail()
            }
        }
    }

    func test_request_whenServerDoesNotSendData_shouldDeliversCorrectError() {
        let (sut, urlSessionSpy, queueSpy, tokenManagerSpy) = makeSUT()
        let route = AnyServiceRoute.get
        urlSessionSpy.responseToBeReturned = makeHTTPURLResponse()

        sut.request(with: route.config) { result in
            switch result {
            case let .failure(responseError):
                XCTAssertEqual(
                    responseError.responseErrorMessage,
                    "Ocorreu um erro desconhecido"
                )
                XCTAssertEqual(queueSpy.receivedMessages, [.async])
                XCTAssertEqual(tokenManagerSpy.receivedMessages, [])

            default:
                XCTFail()
            }
        }
    }

    func test_request_whenServerDoesNotSendDataAndShouldRefreshToken_shouldDeliversCorrectError() {
        let (sut, urlSessionSpy, queueSpy, tokenManagerSpy) = makeSUT()
        let route = RefreshTokenServiceRoute.get
        urlSessionSpy.responseToBeReturned = makeHTTPURLResponse()

        sut.request(with: route.config) { result in
            switch result {
            case let .failure(responseError):
                XCTAssertEqual(
                    responseError.responseErrorMessage,
                    "Ocorreu um erro desconhecido"
                )
                XCTAssertEqual(queueSpy.receivedMessages, [.async])
                XCTAssertEqual(tokenManagerSpy.receivedMessages, [.getToken])

            default:
                XCTFail()
            }
        }
    }

    func test_request_whenItHasSuccess_shouldDeliversCorrectResponse() {
        let (sut, urlSessionSpy, queueSpy, tokenManagerSpy) = makeSUT()
        let expectedData = Data()
        let route = AnyServiceRoute.get
        urlSessionSpy.responseToBeReturned = makeHTTPURLResponse()
        urlSessionSpy.dataToBeReturned = expectedData

        sut.request(with: route.config) { result in
            switch result {
            case let .success(receivedData):
                XCTAssertEqual(receivedData, expectedData)
                XCTAssertEqual(queueSpy.receivedMessages, [.async])
                XCTAssertEqual(tokenManagerSpy.receivedMessages, [])

            default:
                XCTFail()
            }
        }
    }

    func test_request_whenItHasSuccessAndShouldRefreshToken_shouldDeliversCorrectResponse() {
        let (sut, urlSessionSpy, queueSpy, tokenManagerSpy) = makeSUT()
        let expectedData = Data()
        let route = RefreshTokenServiceRoute.get
        urlSessionSpy.responseToBeReturned = makeHTTPURLResponse()
        urlSessionSpy.dataToBeReturned = expectedData

        sut.request(with: route.config) { result in
            switch result {
            case let .success(receivedData):
                XCTAssertEqual(receivedData, expectedData)
                XCTAssertEqual(queueSpy.receivedMessages, [.async])
                XCTAssertEqual(tokenManagerSpy.receivedMessages, [.getToken])

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
        tokenManagerSpy: TokenManagerSpy
    ) {
        let urlSessionSpy = URLSessionSpy()
        let queueSpy = DispatchQueueSpy()
        let tokenManagerSpy = TokenManagerSpy()

        let sut = NetworkManager(
            session: urlSessionSpy,
            queue: queueSpy, 
            tokenManager: tokenManagerSpy
        )

        trackForMemoryLeaks(sut)
        trackForMemoryLeaks(urlSessionSpy)
        trackForMemoryLeaks(queueSpy)
        trackForMemoryLeaks(tokenManagerSpy)

        return (sut, urlSessionSpy, queueSpy, tokenManagerSpy)
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
