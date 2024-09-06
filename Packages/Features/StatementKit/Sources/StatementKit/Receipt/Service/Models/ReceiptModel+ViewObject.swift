import UIKit
import ComponentsKit

extension ReceiptModel {
    func toViewObject() -> ReceiptViewObject {
        let items = makeItems()

        return ReceiptViewObject(
            icon: .add,
            title: label,
            items: makeItemsView(items: items)
        )
    }

    private func makeItems() -> [ReceiptViewObject.Item] {
        [
            ReceiptViewObject.Item(
                title: Strings.receiptValueTitle,
                value: makeValue()
            ),
            ReceiptViewObject.Item(
                title: Strings.receiptDateTitle,
                value: makeDate()
            ),
            ReceiptViewObject.Item(
                title: Strings.receiptOriginTitle,
                value: makeOrigin()
            ),
            ReceiptViewObject.Item(
                title: Strings.receiptDestinationTitle,
                value: makeDestination()
            )
            ,
            ReceiptViewObject.Item(
                title: Strings.receiptDescriptionTitle,
                value: makeFooter()
            )
        ]
    }

    private func makeItemsView(items: [ReceiptViewObject.Item]) -> [ItemView] {
        let item = items.map {
            let view = ItemView()
            view.setupViewObject(viewObject: $0)
            return view
        }
        return item
    }

    private func makeValue() -> NSAttributedString {
        let currencySymbol = "R$"
        let amountString = String(format: "%.2f", amount / 100)
        let fullString = "\(currencySymbol) \(amountString)"

        let attributedString = NSMutableAttributedString(string: fullString)
        let currencyRange = NSRange(location: 0, length: currencySymbol.count)
        let amountRange = NSRange(location: currencySymbol.count + 1, length: amountString.count)

        attributedString.addAttribute(
            .font,
            value: UIFont.regular(size: .x16) as Any,
            range: currencyRange
        )
        attributedString.addAttribute(
            .font,
            value: UIFont.bold(size: .x16) as Any,
            range: amountRange
        )
        attributedString.addAttribute(
            .foregroundColor,
            value: UIColor.black,
            range: NSRange(location: 0, length: fullString.count)
        )

        return attributedString
    }

    private func makeDate() -> NSAttributedString {
        let date = formatDate(dateString: dateEvent)
        let attributedString = NSMutableAttributedString(string: date)
        let range = NSRange(location: 0, length: date.count)
        attributedString.addAttribute(
            .font,
            value: UIFont.bold(size: .x16) as Any,
            range: range
        )
        attributedString.addAttribute(
            .foregroundColor,
            value: Color.offBlack,
            range: range
        )
        return attributedString
    }

    private func formatDate(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.timeZone = TimeZone.current

        guard let date = dateFormatter.date(from: dateString) else {
            return dateString
        }

        let today = Date()
        let calendar = Calendar.current

        if calendar.isDate(date, inSameDayAs: today) {
            dateFormatter.dateFormat = "'Hoje' - d 'de' MMMM"
        } else if let yesterday = calendar.date(byAdding: .day, value: -1, to: today), calendar.isDate(date, inSameDayAs: yesterday) {
            dateFormatter.dateFormat = "'Ontem' - d 'de' MMMM"
        } else {
            dateFormatter.dateFormat = "EEEE - d 'de' MMMM"
        }

        dateFormatter.locale = Locale(identifier: "pt_BR")
        return dateFormatter.string(from: date).capitalized
    }

    private func makeOrigin() -> NSAttributedString {
        let senderNameText = "\(sender.name)\n"
        let documentText = "\(sender.documentType) \(sender.documentNumber)\n"
        let bankText = "\(sender.bankName)\n"
        let accountText = "Agência \(sender.agencyNumber) - Conta \(sender.accountNumber)-\(sender.accountNumberDigit)"

        return makeAccountsFormat(
            nameText: senderNameText,
            documentText: documentText,
            bankText: bankText,
            accountText: accountText
        )

//        let senderAttributes: [NSAttributedString.Key: Any] = [
//            .font: UIFont.bold(size: .x16) as Any,
//            .foregroundColor: Color.offBlack
//        ]
//
//        let otherAttributes: [NSAttributedString.Key: Any] = [
//            .font: UIFont.regular(size: .x14) as Any,
//            .foregroundColor: Color.gray1
//        ]
//
//        let senderAttributedString = NSAttributedString(string: senderNameText, attributes: senderAttributes)
//        let documentAttributedString = NSAttributedString(string: documentText, attributes: otherAttributes)
//        let bankAttributedString = NSAttributedString(string: bankText, attributes: otherAttributes)
//        let accountAttributedString = NSAttributedString(string: accountText, attributes: otherAttributes)
//
//        let finalAttributedString = NSMutableAttributedString()
//        finalAttributedString.append(senderAttributedString)
//        finalAttributedString.append(documentAttributedString)
//        finalAttributedString.append(bankAttributedString)
//        finalAttributedString.append(accountAttributedString)
//
//        return finalAttributedString
    }

    private func makeDestination() -> NSAttributedString {
        let senderNameText = "\(recipient.name)\n"
        let documentText = "\(recipient.documentType) \(recipient.documentNumber)\n"
        let bankText = "\(recipient.bankName)\n"
        let accountText = "Agência \(recipient.agencyNumber) - Conta \(sender.accountNumber)-\(recipient.accountNumberDigit)"

        return makeAccountsFormat(
            nameText: senderNameText,
            documentText: documentText,
            bankText: bankText,
            accountText: accountText
        )
    }

    private func makeAccountsFormat(
        nameText: String,
        documentText: String,
        bankText: String,
        accountText: String
    ) -> NSAttributedString {
        let nameAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.bold(size: .x16) as Any,
            .foregroundColor: Color.offBlack
        ]

        let otherAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.regular(size: .x14) as Any,
            .foregroundColor: Color.gray1
        ]

        let nameAttributedString = NSAttributedString(string: nameText, attributes: nameAttributes)
        let documentAttributedString = NSAttributedString(string: documentText, attributes: otherAttributes)
        let bankAttributedString = NSAttributedString(string: bankText, attributes: otherAttributes)
        let accountAttributedString = NSAttributedString(string: accountText, attributes: otherAttributes)

        let finalAttributedString = NSMutableAttributedString()
        finalAttributedString.append(nameAttributedString)
        finalAttributedString.append(documentAttributedString)
        finalAttributedString.append(bankAttributedString)
        finalAttributedString.append(accountAttributedString)

        return finalAttributedString
    }

    private func makeFooter() -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: Strings.receiptDescriptionText)
        let range = NSRange(location: 0, length: Strings.receiptDescriptionText.count)
        attributedString.addAttribute(
            .font,
            value: UIFont.regular(size: .x14) as Any,
            range: range
        )
        attributedString.addAttribute(
            .foregroundColor,
            value: Color.gray1,
            range: range
        )
        return attributedString
    }
}
