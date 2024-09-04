import UIKit
import RouterKit
import LauncherKit

final class LauncherRouteDescriptor: RouteDescriptor {
    init() {}

    func match(url: URL) -> Bool {
        return url.host == RouterPaths.launcher
    }

    func start(url: URL, on navigator: UINavigationController?) { 
        LauncherComposer.startScene(navigator)
    }
}
