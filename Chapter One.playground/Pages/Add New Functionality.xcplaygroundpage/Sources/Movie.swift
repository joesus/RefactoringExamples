public class Movie {
    public static let CHILDRENS = 2
    public static let REGULAR = 0
    public static let NEW_RELEASE = 1

    private var title: String
    private var priceCode: Int

    public init(title: String, priceCode: Int) {
        self.title = title
        self.priceCode = priceCode
    }

    public func getPriceCode() -> Int {
        return priceCode
    }

    public func setPriceCode(value: Int) {
        priceCode = value
    }

    public func getTitle() -> String {
        return title
    }
}
