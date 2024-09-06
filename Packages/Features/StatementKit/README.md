# StatementKit

`StatementKit` is a module designed to manage the user's transaction statements, providing a structured overview of transaction history with detailed information and filtering capabilities.

## Architecture

### Statement

#### Composition

- `StatementComposer`: Responsible for setting up and initializing the statement scene.
- `StatementCoordinator`: Manages the navigation flow within the statement scene. It handles transitions to other screens, such as navigating to receipt details, and displays error messages when needed.

#### Presentation
- `StatementViewController`: Manages the user interface of the statement screen, including handling user input, displaying transactions, and applying filters. It interacts with the `StatementViewModel` to update the UI based on the data fetched from the service.
- `StatementViewModel`: Handles the business logic associated with fetching and displaying the user's transaction statements. It processes the data fetched from the `StatementService`, organizes it into view objects, and manages the state of the UI elements.

#### Service
- `StatementService`: Handles network requests related to fetching transaction statements. It interacts with `NetworkManager` to send requests and processes the responses to ensure the correct data is presented to the user.
- `StatementServiceRoute`: Defines the routes used by the `StatementService` for network requests. It includes configurations for making HTTP requests, such as the path, method, and parameters.

### Receipt

#### Composition

- `ReceiptComposer`: Sets up and initializes the password entry scene.
- `ReceiptCoordinator`: Manages the navigation flow and interaction within the receipt detail scene. It handles transitions to other screens, displays error messages, and facilitates the sharing of receipt details via a share sheet.

#### Presentation

- `ReceiptViewController`: Manages the user interface of the receipt detail screen, including handling user input and displaying receipt details. It interacts with the `ReceiptViewModel` to update the UI based on the data fetched from the service.
- `ReceiptViewModel`: Handles the business logic associated with displaying receipt details. It processes the data fetched from the `ReceiptService`, organizes it into view objects, and manages the state of the UI elements.

#### Service

- `ReceiptService`: Handles network requests related to fetching receipt details. It interacts with `NetworkManager` to send requests and processes the responses to ensure the correct data is presented to the user.
- `ReceiptServiceRoute`: Defines the routes used by the `ReceiptService` for network requests. It includes configurations for making HTTP requests, such as the path, method, and parameters.

## Usage

```swift
// To start launcher flow, just call the function bellow
if let url = URL(string: RouterURLs.statement) {
    routingHub.start(url: url, on: navigation)
}
```
