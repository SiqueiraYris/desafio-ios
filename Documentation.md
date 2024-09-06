# ChallengeApp

This project is intended to make login and show the user transactions.

## Features

- Welcome screen;
- Login;
- Show user statement;
- Show transaction detail;
- Share transaction receipt.

## Build and Runtime Requirements

- Xcode 15.2 or later
- iOS 15.0 or later

## Installation

Clone the repository:
`https://github.com/SiqueiraYris/desafio-ios`

Go to folder:
`ChallengeApp/Resources/Configurations/Environment`

Change the values in files (replace them value with your API Key):
Development.xcconfig: `NETWORK_KIT_API_KEY`
Production.xcconfig: `NETWORK_KIT_API_KEY`

Back to root folder:
`ChallengeApp`

Open the file:
`ChallengeApp.xcodeproj`

Run:
`Command + R`

## Architecture

The project is structured based on the `MVVM-C` design pattern and clean architecture. The app is a set of modules each module is basically (but not necessary) a screen of the app, where each one is a SPM (Swift Package Manager). They are all located in the `Packages` folder.

- `ViewController`: responsible for building the UI and receive user events.
- `ViewModel`: responsible for making the logic and receive events from `ViewController`.
- `Service`: responsible for making requests for backend.
    - `ServiceRoute`: responsible for defining request parameters.
- `Coordinator`: responsible for making the navigation and flow control.
- `Composer`: responsible for having the concrete instances of objects.

The project has an `Application` folder where are the app startup files located. It also has a `Resources` folder where are the project assets, configurations etc. The `Navigation` folder inside `Application` is the possible app navigation routes.

The app has two schemes allowing you to change environments (Development and Production). Today it only has a host address provided by Cora, but if a development address appears, the app is already prepared.

### Modularization

The application has some utility modules (Foundation):
- `DynamicKit`: used to do reactive programming.
- `RouterKit`: manager the app navigation, based on URLs.
- `NetworkKit`: manages all requests with the backend, exposing only one manager.
- `ComponentsKit`: centralizes the components, colors and UI tokens of the app.

The application has three feature modules:
- `LauncherKit`: responsible for showing the welcome screen and redirect user to selected flow.
- `LoginKit`: responsible for showing the document and password screen, making input validations and making login.
- `StatementKit`: responsible for showing the list of user transactions, transaction detail and share transaction receipt.

### Unit Tests

- `DynamicKit`: unit tests are located in `DynamicKitTests`, the code coverage is 100%.
- `RouterKit`: unit tests are located in `RouterKitTests`, the code coverage is 99%.
- `NetworkKit`: unit tests are located in `NetworkKitTests`, the code coverage is 88%.
- `LauncherKit`: unit tests are located in `LauncherKitTests`, the code coverage is 91%.
- `LoginKit`: unit tests are located in `LoginKitTests`, the code coverage is 87%.
- `StatementKit`: unit tests are located in `StatementKitTests`, the code coverage is 88%.

## Next steps

- Add other languages (internationalization);
- Add Snapshot tests to `ComponentsKit`;
- Add UITests;
- Change `DynamicKit` to `Combine`;
- Use `Combine` in `RouterKit`;
- Add XcodeGen to avoid pbx conflicts;
- Update UI to SwiftUI.


## Note

Ideally, it wouldn't be best to refresh the token every 1 minute automatically, as it is not scalable. However, this approach was implemented because it was one of the test requirements to validate knowledge about concurrency.
