import UIKit
import ComponentsKit

enum EntryType: String {
    case debit = "DEBIT"
    case credit = "CREDIT"
}

extension StatementModel {
    func toViewObject() -> StatementViewObject {
        let sections = results.map { result -> StatementViewObject.Section in
            let rows = result.items.map { item -> StatementViewObject.Row in
                return StatementViewObject.Row(
                    id: item.id,
                    icon: icon(for: item.entry), //missing
                    title: makeAttributedTitle(amount: item.amount, entry: item.entry),
                    subtitle: item.label,
                    subtitleColor: getSubtitleColor(entry: item.entry),
                    description: item.name,
                    time: getTime(item.dateEvent)
                )
            }
            return StatementViewObject.Section(
                title: getSectionDate(dateString: result.date), 
                rows: rows
            )
        }

        return StatementViewObject(sections: sections)
    }

    private func icon(for entry: String) -> UIImage? {
        let type = EntryType(rawValue: entry)

        if type == .credit {
            return Images.arrowDown
        }

        return Images.arrowUpOut
    }

    private func getSubtitleColor(entry: String) -> UIColor {
        switch EntryType(rawValue: entry) {
        case .credit:
            return Color.secondaryMain

        default:
            return Color.offBlack
        }
    }

    private func getTime(_ dateString: String) -> String {
        let dateFormatter = ISO8601DateFormatter()
        if let date = dateFormatter.date(from: dateString) {
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "HH:mm"
            timeFormatter.timeZone = TimeZone(abbreviation: "UTC")
            return timeFormatter.string(from: date)
        } else {
            return dateString
        }
    }

    private func getSectionDate(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
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

    private func makeAttributedTitle(amount: Double, entry: String) -> NSAttributedString {
        let type = EntryType(rawValue: entry)
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

        let color = (type == .credit) ? Color.secondaryMain : Color.offBlack
        attributedString.addAttribute(
            .foregroundColor,
            value: color,
            range: NSRange(location: 0, length: fullString.count)
        )

        return attributedString
    }
}
