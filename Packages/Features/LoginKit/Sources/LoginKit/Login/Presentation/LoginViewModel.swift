import DynamicKit

protocol LoginViewModelProtocol {
    var isButtonEnabled: Dynamic<Bool> { get }
    var updatedDocument: Dynamic<String?> { get }

    func validateDocument(text: String?)
    func openPassword(document: String?)
}

final class LoginViewModel: LoginViewModelProtocol {
    // MARK: - Properties

    private let coordinator: LoginCoordinatorProtocol

    var isButtonEnabled: Dynamic<Bool> = Dynamic(false)
    var updatedDocument: Dynamic<String?> = Dynamic(nil)

    // MARK: - Initializer

    init(coordinator: LoginCoordinatorProtocol) {
        self.coordinator = coordinator
    }

    // MARK: - Methods

    func validateDocument(text: String?) {
        guard let text = text else { return }

        let documentMaxLength = 11
        let cleanedDocument = text.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        let limitedDocument = String(cleanedDocument.prefix(documentMaxLength))
        let formattedDocument = formatDocument(limitedDocument)

        updatedDocument.value = formattedDocument

        if limitedDocument.count == documentMaxLength && isValidCPF(limitedDocument) {
            isButtonEnabled.value = true
        } else {
            isButtonEnabled.value = false
        }
    }

    func openPassword(document: String?) {
        guard let document else { return }
        coordinator.openPassword(document: document)
    }

    private func formatDocument(_ document: String) -> String {
        var formattedDocument = document

        if document.count > 3 {
            formattedDocument.insert(".", at: formattedDocument.index(formattedDocument.startIndex, offsetBy: 3))
        }

        if document.count > 6 {
            formattedDocument.insert(".", at: formattedDocument.index(formattedDocument.startIndex, offsetBy: 7))
        }

        if document.count > 9 {
            formattedDocument.insert("-", at: formattedDocument.index(formattedDocument.startIndex, offsetBy: 11))
        }

        return formattedDocument
    }

    private func isValidCPF(_ document: String) -> Bool {
        let numbers = document.compactMap { $0.wholeNumberValue }
        guard numbers.count == 11 && Set(numbers).count != 1 else { return false }

        func digitCalculator(_ slice: ArraySlice<Int>) -> Int {
            var number = slice.count + 2
            let digit = 11 - slice.reduce(into: 0) {
                number -= 1
                $0 += $1 * number
            } % 11
            return digit > 9 ? 0 : digit
        }

        let dv1 = digitCalculator(numbers.prefix(9))
        let dv2 = digitCalculator(numbers.prefix(10))
        return dv1 == numbers[9] && dv2 == numbers[10]
    }
}
