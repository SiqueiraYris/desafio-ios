# LoginKit

`LoginKit` is a module designed to manage the user authentication flow in an application, providing a seamless experience from the login screen to secure access to the application’s features. 

## Architecture

### Login

#### Composition

- `LoginComposer`: Responsible for setting up and initializing the login scene.
- `LoginCoordinator`: Manages the navigation flow from the login screen to the password screen or other subsequent screens. It ensures that the appropriate screens are presented to the user based on their actions during the login process.

#### Presentation
- `LoginViewController`: Manages the login screen's user interface, including handling user input, form validation, and navigation. It presents the UI elements like text fields and buttons, and interacts with the `LoginViewModel` to validate input and trigger navigation.
- `LoginViewModel`: Handles the business logic associated with the login process, including input validation and interaction with the coordinator. It manages the state of the login screen, such as enabling or disabling the login button based on input validation, and formats the document ID as needed.

### Password

#### Composition

- `PasswordComposer`: Sets up and initializes the password entry scene.
- `PasswordCoordinator`: Manages the navigation flow within the password entry process and subsequent steps. It handles transitions after successful password entry, such as navigating to the main application screen, and displays error messages when authentication fails.

#### Presentation

- `PasswordViewController`: Manages the password entry screen's user interface, including handling user input, form validation, and navigation. It presents UI elements for password entry, and interacts with the `PasswordViewModel to validate passwords and trigger login attempts.
- `PasswordViewModel`: Handles the business logic associated with the password entry process, including password validation, interaction with the `PasswordService` for authentication, and managing the state of the UI elements (e.g., enabling the login button when the password is valid).

#### Providers

- `PasswordTokenManager`: Manages the storage and retrieval of authentication tokens after a successful login. It interacts with the `TokenKit to securely store tokens and provide them when needed for authenticated requests.

#### Service

- `PasswordService`: Handles network requests related to user authentication. It interacts with the `NetworkManager to send login requests and processes the responses, determining whether the authentication was successful or not.
- `PasswordServiceRoute`: Defines the routes used by the `PasswordService` for network requests. It includes configurations for making HTTP requests, such as the path, method, encoding, and parameters, ensuring that the correct data is sent to the server during the login process.

## Usage

```swift
// To start launcher flow, just call the function bellow
if let url = URL(string: RouterURLs.login) {
    routingHub.start(url: url, on: navigation)
}
```
