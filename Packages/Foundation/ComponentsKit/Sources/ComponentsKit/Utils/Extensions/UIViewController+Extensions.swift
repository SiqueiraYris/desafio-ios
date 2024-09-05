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

    func setupDismissKeyboard(cancelsTouchesInView: Bool = true) {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapDismissKeyboard))
        tapRecognizer.cancelsTouchesInView = cancelsTouchesInView
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

    private static let loaderTag = 999

    func showLoader() {
        guard let window = UIApplication.shared.keyWindow else { return }

        if window.viewWithTag(UIViewController.loaderTag) != nil {
            return
        }

        let loaderView = UIView()
        loaderView.backgroundColor = Color.gray1.withAlphaComponent(0.2)
        loaderView.tag = UIViewController.loaderTag
        loaderView.translatesAutoresizingMaskIntoConstraints = false

        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = Color.primaryMain
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()

        loaderView.addSubview(activityIndicator)
        window.addSubview(loaderView)

        NSLayoutConstraint.activate([
            loaderView.topAnchor.constraint(equalTo: window.topAnchor),
            loaderView.leadingAnchor.constraint(equalTo: window.leadingAnchor),
            loaderView.trailingAnchor.constraint(equalTo: window.trailingAnchor),
            loaderView.bottomAnchor.constraint(equalTo: window.bottomAnchor),

            activityIndicator.centerXAnchor.constraint(equalTo: loaderView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: loaderView.centerYAnchor)
        ])
    }

    func hideLoader() {
        guard let window = UIApplication.shared.keyWindow else { return }
        if let loaderView = window.viewWithTag(UIViewController.loaderTag) {
            loaderView.removeFromSuperview()
        }
    }
}
