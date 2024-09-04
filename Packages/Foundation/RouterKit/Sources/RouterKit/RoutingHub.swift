import UIKit

public protocol RoutingHubProtocol {
    var descriptors: [RouteDescriptor] { get }

    func start(url: URL, on navigation: UINavigationController?)
    func register(descriptor: RouteDescriptor)
}

public final class RoutingHub: RoutingHubProtocol {
    public var descriptors: [RouteDescriptor] = []
    public weak var rootViewController: UINavigationController?
    private var scheme: String
    private let urlProtocol: String

    public static var shared = RoutingHub(scheme: RouterHost.scheme)

    public init(scheme: String) {
        self.scheme = scheme
        self.urlProtocol = RouterHost.url
    }

    public func register(descriptor: RouteDescriptor) {
        descriptors.append(descriptor)
    }

    public func start(url: URL, on navigation: UINavigationController?) {
        guard let descriptor = descriptors.first(where: { $0.match(url: url) }) else {
            return
        }

        descriptor.start(url: url, on: navigation)
    }
}
