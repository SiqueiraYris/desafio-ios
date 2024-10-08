import DynamicKit
import UIKit

protocol PasswordViewModelProtocol {
    var isLoading: Dynamic<Bool> { get }
    var isButtonEnabled: Dynamic<Bool> { get }
    var updatedDocument: Dynamic<String?> { get }

    func validatePassword(text: String?)
    func login(password: String?)
    func getImage(isSecureTextEntry: Bool) -> UIImage?
}

final class PasswordViewModel: PasswordViewModelProtocol {
    // MARK: - Properties

    private let coordinator: PasswordCoordinatorProtocol
    private let service: PasswordServiceProtocol
    private let document: String
    private var password = ""

    var isLoading = Dynamic(false)
    var isButtonEnabled: Dynamic<Bool> = Dynamic(false)
    var updatedDocument: Dynamic<String?> = Dynamic(nil)

    // MARK: - Initializer

    init(coordinator: PasswordCoordinatorProtocol,
         service: PasswordServiceProtocol,
         document: String) {
        self.coordinator = coordinator
        self.service = service
        self.document = document
    }

    // MARK: - Methods

    func validatePassword(text: String?) {
        guard let text = text else { return }

        let passwordMaxLength = 6

        let limitedPassword = String(text.prefix(passwordMaxLength))
        updatedDocument.value = limitedPassword

        if limitedPassword.count == passwordMaxLength {
            isButtonEnabled.value = true
        } else {
            isButtonEnabled.value = false
        }
    }

    func login(password: String?) {
        guard let password else { return }
        self.password = password
        isLoading.value = true

        let route = PasswordServiceRoute.login(document: document, password: password)
        service.makeLogin(route: route) { [weak self] result in
            guard let self else { return }
            self.isLoading.value = false

            switch result {
            case .success:
                self.coordinator.openStatement()

            case let .failure(responseError):
                self.coordinator.showErrorAlert(with: responseError.responseErrorMessage) {
                    self.login(password: self.password)
                }
            }
        }
    }

    func getImage(isSecureTextEntry: Bool) -> UIImage? {
        return isSecureTextEntry ? Images.eyeHidden : Images.eye
    }
}
