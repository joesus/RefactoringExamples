//: [Previous](@previous)

/*:
 ### Apply Move Method to 'getCharge'
 */

protocol Price {
    func getPriceCode() -> Int // This should be a PriceCode but leaving it for now in the spirit of tiny changes at a time
    func getCharge(daysRented: Int) -> Double
}

extension Price {
    func getCharge(daysRented: Int) -> Double {
        var result = 0.0
        switch getPriceCode() {
        case PriceCode.regular.rawValue:
            result += 2
            if daysRented > 2 {
                result += Double(daysRented - 2) * 1.5
            }
        case PriceCode.newRelease.rawValue:
            result += Double(daysRented) * 3
        case PriceCode.childrens.rawValue:
            result += 1.5
            if daysRented > 3 {
                result += Double(daysRented - 3) * 1.5
            }
        default:
            break
        }
        return result
    }
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
//    public static let CHILDRENS = 2
//    public static let REGULAR = 0
//    public static let NEW_RELEASE = 1

    private var title: String
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

    func price(forValue: Int) -> Price {
        return ChildrensPrice()
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

    // Update to use priceCode getter
    func getCharge(daysRented: Int) -> Double {
        return price.getCharge(daysRented: daysRented)
// Moved
//        var result = 0.0
//        switch getPriceCode() {
//        case Movie.REGULAR:
//            result += 2
//            if daysRented > 2 {
//                result += Double(daysRented - 2) * 1.5
//            }
//        case Movie.NEW_RELEASE:
//            result += Double(daysRented) * 3
//        case Movie.CHILDRENS:
//            result += 1.5
//            if daysRented > 3 {
//                result += Double(daysRented - 3) * 1.5
//            }
//        default:
//            break
//        }
//        return result
    }

    func getFrequentRenterPoints(daysRented: Int) -> Int {
        if getPriceCode() == PriceCode.newRelease.rawValue,
            daysRented > 1 {
            return 2
        } else {
            return 1
        }
    }
}

//: [Next](@next)
