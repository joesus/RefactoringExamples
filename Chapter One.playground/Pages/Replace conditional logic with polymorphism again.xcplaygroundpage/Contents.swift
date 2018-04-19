//: [Previous](@previous)

/*:
 ### Replace conditional logic with polymorphism

 Seems like it's generally swiftier to put the conditional logic in a default implementation on the enum and then delegate it to the specific enum cases (polymorphism)
 */

protocol Price {
    func getPriceCode() -> Int // This should be a PriceCode but leaving it for now in the spirit of tiny changes at a time
    func getCharge(daysRented: Int) -> Double
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

//: [Next](@next)
