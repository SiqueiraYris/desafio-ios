import UIKit

public extension UIViewController {
    func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = Color.gray4
        appearance.titleTextAttributes = [.foregroundColor: Color.gray1,
                                          .font: UIFont.regular(size: .x14) as Any]
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance

        let backIcon = UIImage(systemName: "ic_chevron-left")
        navigationController?.navigationBar.backIndicatorImage = backIcon
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = backIcon
        navigationItem.leftItemsSupplementBackButton = true
        let backButton = UIBarButtonItem(
            title: "",
            style: .plain,
            target: self,
            action: nil
        )
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        navigationController?.navigationBar.tintColor = Color.primaryMain
    }

    func setupDismissKeyboard() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapDismissKeyboard))
        tapRecognizer.cancelsTouchesInView = false

        view.addGestureRecognizer(tapRecognizer)
    }

    @objc private func didTapDismissKeyboard() {
        view.endEditing(true)
    }

    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }

    private func adjustConstraints(showingKeyboard: Bool, notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
              let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval,
              let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt
        else { return }

        UIView.animate(withDuration: animationDuration,
                       delay: 0.0,
                       options: UIView.AnimationOptions(rawValue: curve),
                       animations: {
            self.animateKeyboard(withHeight: keyboardSize.height, showingKeyboard: showingKeyboard)
            self.view.layoutIfNeeded()
        }, completion: nil)
    }

    @objc func keyboardWillShow(notification: Notification) {
        adjustConstraints(showingKeyboard: true, notification: notification)
    }

    @objc func keyboardWillHide(notification: Notification) {
        adjustConstraints(showingKeyboard: false, notification: notification)
    }

    @objc open func animateKeyboard(withHeight height: CGFloat, showingKeyboard: Bool) { }
}
