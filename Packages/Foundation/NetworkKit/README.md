# NetworkKit

`NetworkKit` is a library designed to facilitate network request management in an application. It provides an interface for making network requests, managing sessions and handling header interceptors.

## Architecture

`NetworkManager` is the main class responsible for managing network requests. 

```swift
public protocol NetworkManagerProtocol {
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
```
