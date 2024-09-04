import UIKit
import RouterKit

final class StatementRouteDescriptor: RouteDescriptor {
    init() {}

    func match(url: URL) -> Bool {
        return url.host == RouterPaths.statement
    }

    func start(url: URL, on navigator: UINavigationController?) { }
}
