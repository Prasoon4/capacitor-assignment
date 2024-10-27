import Foundation

class DateUtils {

    private static let dateFormat = "yyyy-MM-dd"

    private static func getDateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter
    }

    static func parseDate(_ strDate: String) -> Date? {
        return getDateFormatter().date(from: strDate)
    }

    static func parseDate(_ date: Date) -> String {
        return getDateFormatter().string(from: date)
    }
}
