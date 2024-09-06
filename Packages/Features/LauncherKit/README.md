# LauncherKit

`LauncherKit` is a module designed to handle the launch process of an application, providing a smooth and consistent user experience with a coordinated flow between the initial launch screen and subsequent screens.

## Architecture

### Composition
- `LauncherComposer`: Responsible for composing and setting up the initial view controller, ensuring that all necessary dependencies are provided and configured.
- `LauncherCoordinator`: Manages the flow and navigation from the launcher screen to other screens within the app. It uses RouterKit for handling routing and coordinates the transition to the login screen or other subsequent screens.

## Presentation
- `LauncherViewController`: The main view controller for the launcher screen, responsible for displaying the initial UI, including the app logo, background, title, subtitle, and primary and secondary action buttons.
- `LauncherViewModel`: Handles the business logic and data binding for the LauncherViewController. It interacts with the coordinator to navigate to other screens based on user actions.

## Usage

```swift
// To start launcher flow, just call the function bellow
if let url = URL(string: RouterURLs.launcher) {
    routingHub.start(url: url, on: navigation)
}
```
