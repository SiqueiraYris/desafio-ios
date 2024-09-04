import UIKit
import RouterKit

final class LoginRouteDescriptor: RouteDescriptor {
    init() {}

    func match(url: URL) -> Bool {
        return url.host == RouterPaths.login
    }

    func start(url: URL, on navigator: UINavigationController?) { }
}
