# RouterKit

`RouterKit` is a library designed to manage URL-based navigation within an application. It provides a flexible way to define and handle routes, allowing for easy navigation based on URL schemes.

## Architecture

The `RoutingHubProtocol` defines the essential methods for managing route descriptors and starting navigation based on URLs. The `RoutingHub` class implements the `RoutingHubProtocol and manages a collection of route descriptors. It handles the registration of routes and the initiation of navigation based on URLs.
The RouteDescriptor protocol defines the essential methods for matching and starting routes based on URLs.

```swift
public protocol RouteDescriptor: AnyObject {
    func match(url: URL) -> Bool
    func start()
    func start(url: URL)
    func start(url: URL, on viewController: UIViewController)
    func start(url: URL, on navigator: UINavigationController)
}
```

## Usage

```swift
// Registering a route descriptor
let routeDescriptor: RouteDescriptor = MyRouteDescriptor() // Implement your RouteDescriptor
RoutingHub.shared.register(descriptor: routeDescriptor)

// Starting navigation
if let url = URL(string: "myapp://example") {
    RoutingHub.shared.start(url: url)
}

// Starting navigation with a specific UINavigationController
let navigationController = UINavigationController()
RoutingHub.shared.start(url: url, on: navigationController)

// Transforming a Shortcut Type to URL
if let url = RoutingHub.shared.transformShortcutTypeInURL("myapp.exampleShortcut") {
    print("Transformed URL: \(url)")
}
```
