import UIKit
import RouterKit

final class RoutingHubSpy: RoutingHubProtocol {
    // MARK: - Properties

    var descriptors: [RouteDescriptor] = []

    enum Message: Equatable {
        case start(url: URL, navigation: UINavigationController?)
        case register
    }

    var receivedMessages = [Message]()

    // MARK: - Methods

    func start(url: URL, on navigation: UINavigationController?) {
        receivedMessages.append(.start(url: url, navigation: navigation))
    }

    func register(descriptor: RouteDescriptor) {
        receivedMessages.append(.register)
    }
}
