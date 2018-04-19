//: [Previous](@previous)

/*:
 ### Replace conditional logic with polymorphism

 Seems like it's generally swiftier to put the conditional logic in a default implementation on the enum and then delegate it to the specific enum cases (polymorphism)
 */

protocol Price {
    func getPriceCode() -> Int
    func getCharge(daysRented: Int) -> Double
    func getFrequentRenterPoints(_: Int) -> Int
}

extension Price {
    func getFrequentRenterPoints(_ daysRented: Int) -> Int {
        // Since there's only a special case for new releases, add conformance to that one but leave
        // a default here
        return 1
    }
}

class ChildrensPrice: Price {
    func getPriceCode() -> Int {
        return PriceCode.childrens.rawValue
    }

    func getCharge(daysRented: Int) -> Double {
        var result = 1.5
        if daysRented > 3 {
            result += Double(daysRented - 3) * 1.5
        }
        return result
    }
}

class RegularPrice: Price {
    func getPriceCode() -> Int {
        return PriceCode.regular.rawValue
    }

    func getCharge(daysRented: Int) -> Double {
        var result = 2.0
        if daysRented > 2 {
            result += Double(daysRented - 2) * 1.5
        }
        return result
    }

    // Only special override for this one
    func getFrequentRenterPoints(_ daysRented: Int) -> Int {
        return daysRented > 1 ? 2 : 1
    }
}

class NewReleasePrice: Price {
    func getPriceCode() -> Int {
        return PriceCode.newRelease.rawValue
    }

    func getCharge(daysRented: Int) -> Double {
        return Double(daysRented) * 3
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

    func getCharge(daysRented: Int) -> Double {
        return price.getCharge(daysRented: daysRented)
    }

    func getFrequentRenterPoints(daysRented: Int) -> Int {
        return price.getFrequentRenterPoints(daysRented)
//
// Moved to price
//
//        if getPriceCode() == PriceCode.newRelease.rawValue,
//            daysRented > 1 {
//            return 2
//        } else {
//            return 1
//        }
    }
}


//: [Next](@next)
