# DynamicKit

`DynamicKit` is a library designed to provide a dynamic binding mechanism, allowing values to be observed and reacted to in real-time. It enables you to create observable properties and track changes over time.

## Architecture

The Dynamic` class wraps a value of any type and allows listeners to be notified whenever the value changes. It supports binding a listener to react to value changes and ensures that updates are dispatched on the main thread.
The `DynamicObserver` class tracks all values set to the Dynamic instance, maintaining a history of changes.

## Usage

```swift
// Creating a dynamic property
let dynamicString = Dynamic<String>("Initial Value")

// Binding a listener
dynamicString.bind { newValue in
    print("Value changed to: \(newValue)")
}

// Updating the value
dynamicString.value = "Updated Value"

// Observing value changes
let observer = DynamicObserver<String>()
dynamicString.observer = observer

dynamicString.value = "First Change"
dynamicString.value = "Second Change"

print(observer.values) // Output: ["First Change", "Second Change"]
```
