# ComponentsKit

`ComponentsKit` is a library designed to provide reusable components and customizable themes, making it easier to create consistent and visually appealing interfaces in your applications.

## Architecture

### Components
The components are the building blocks of `ComponentsKit`. They provide the foundation for creating consistent user interfaces and include:

`Button`: Configurable button components with support for different sizes and styles.
`Label`: Customizable label components.
Skeleton`: Components for creating skeleton views to indicate loading states.

### Tokens
Tokens are the design elements that define the visual identity of your components. They include:
`Border`: Defines border properties like width and color.
`Color`: A set of colors used across the components.
`Font`: Specifies the font types used in the components.
`FontSize`: Defines the size of the fonts.
`Spacing`: Manages spacing between and within components.

### Utils

#### UIButton
- `addUnderline`: This extension method allows you to add an underline to the title of a UIButton with an optional extra spacing for the underline.

#### UIView
- `asImage`: This extension allows you to convert any UIView into a UIImage, which can be useful for creating snapshots of views.

#### UIViewController
- `setupNavigationBar`: This method configures the navigation bar with a custom appearance, setting the background color, text attributes, and back button icon.
- `setupDismissKeyboard`: Adds a gesture recognizer to dismiss the keyboard when the view is tapped outside of a text field or other input view.
- `registerKeyboardNotifications`: Registers notifications to adjust the view's constraints when the keyboard is shown or hidden. This helps ensure that your content remains visible and accessible when typing.
- `showLoader`: Displays a full-screen loading indicator, typically used when waiting for data to load or a process to complete.
- `hideLoader`: Removes the loading indicator from the screen.
- `showSkeletonLoader`: Displays a skeleton loader consisting of alternating large and small skeleton views, which can be used to indicate loading content.
- `hideSkeletonLoader`: Removes the skeleton loader from the view.


## Usage

```swift
// Import ComponentsKit
import ComponentsKit

// Create a button with a specific style and size
let button = Button(style: .primary, size: .large)
button.setTitle("Click Me", for: .normal)

// Add button underline
let button = UIButton()
button.setTitle("Underlined Button", for: .normal)
button.addUnderline(withExtraSpacing: 3.0)

// Create a snapshot of some view
let imageView = UIImageView(image: myView.asImage())

// Setup the default navigation bar
override func viewDidLoad() {
    super.viewDidLoad()
    setupNavigationBar()
}

// Setup to dismiss keyboard
override func viewDidLoad() {
    super.viewDidLoad()
    setupDismissKeyboard()
}

// Handle the keyboard
override func viewDidLoad() {
    super.viewDidLoad()
    registerKeyboardNotifications()
}

// Show/hide loader in View Controller
showLoader()
// Perform a task
hideLoader()

// Show/hide skeleton in screen
showSkeletonLoader(in: self.view)
// Perform a task
hideSkeletonLoader()
```
