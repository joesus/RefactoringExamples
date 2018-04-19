//: [Previous](@previous)

/*:
 ### Self Encapsulate Field

 Basically using getter and setter methods to be able to change the variable type without breaking anything.
 Because swift won't let you call instance methods in an initializer, I was forced to create a new price
 code enum in order to be able to set the price.
 */

protocol Price {
    func getPriceCode() -> Int
}

class ChildrensPrice: Price {
    func getPriceCode() -> Int {
        return PriceCode.childrens.rawValue
    }
}
class RegularPrice: Price {
    func getPriceCode() -> Int {
        return PriceCode.regular.rawValue
    }
}
class NewReleasePrice: Price {
    func getPriceCode() -> Int {
        return PriceCode.newRelease.rawValue
    }
}

enum PriceCode: Int {
    case regular, newRelease, childrens

    func getPrice() -> Price {
        switch self {
        case .childrens: return ChildrensPrice()
        case .regular: return RegularPrice()
        case .newRelease: return NewReleasePrice()
        }
    }
}

public class Movie {
    public static let CHILDRENS = 2
    public static let REGULAR = 0
    public static let NEW_RELEASE = 1

    private var title: String
// Accessing by setter and getter will allow for easily changing this variable name
//    private var priceCode: PriceCode
    private var price: Price

    public init(title: String, priceCode: Int) {
        self.title = title

        guard let priceCode = PriceCode(rawValue: priceCode) else {
            fatalError("Invalid price code")
        }
        price = priceCode.getPrice()
    }

    public func getPriceCode() -> Int {
        return price.getPriceCode()
    }

    public func setPriceCode(value: Int) {
        guard let priceCode = PriceCode(rawValue: value) else {
            fatalError("Invalid price code")
        }
        price = priceCode.getPrice()
    }

    public func getTitle() -> String {
        return title
    }
    func getCharge(daysRented: Int) -> Double {
        var result = 0.0
        switch getPriceCode() {
        case Movie.REGULAR:
            result += 2
            if daysRented > 2 {
                result += Double(daysRented - 2) * 1.5
            }
        case Movie.NEW_RELEASE:
            result += Double(daysRented) * 3
        case Movie.CHILDRENS:
            result += 1.5
            if daysRented > 3 {
                result += Double(daysRented - 3) * 1.5
            }
        default:
            break
        }
        return result
    }
    func getFrequentRenterPoints(daysRented: Int) -> Int {
        if priceCode == Movie.NEW_RELEASE,
            daysRented > 1 {
            return 2
        } else {
            return 1
        }
    }
}

//: [Next](@next)
