# NetworkKit

`NetworkKit` is a library designed to facilitate network request management in an application. It provides an interface for making network requests, managing sessions, handling header interceptors, and checking connectivity.

## Architecture

`NetworkManager` is the main class responsible for managing network requests. It uses a custom URL session, a dispatch queue, a token header interceptor, and a reachability checker to ensure requests are only made when there is an available connection.

```swift
public protocol NetworkManagerProtocol {
    static var shared: NetworkManager { get }
    var isConnectionEnabled: Bool { get }

    func request(with config: RequestConfigProtocol,
                 completion: @escaping (ResponseResult) -> Void)
}
```

## Usage

```swift
// Making a network request
let config: RequestConfigProtocol = MyRequestConfig() // Implement your RequestConfigProtocol
NetworkManager.shared.request(with: config) { result in
    switch result {
    case .success(let data):
        // Handle received data
        print("Data received: \(data)")
    case .failure(let error):
        // Handle error
        print("Error: \(error)")
    }
}

// Checking connectivity
if NetworkManager.shared.isConnectionEnabled {
    print("Connection is enabled")
} else {
    print("No connection")
}
```
