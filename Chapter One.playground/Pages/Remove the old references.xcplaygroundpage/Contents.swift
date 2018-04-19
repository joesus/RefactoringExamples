//: [Previous](@previous)

/*:
 ### Removing the Old References

 Find places where you're using the existing amountFor(_:). At this point it's just a pass-through to the underlying object. Replace it with a direct call to the object.

 */

public class Customer {

    private let name: String
    private var rentals = [Rental]()

    public init(name: String) {
        self.name = name
    }
    public func addRental(rental: Rental) {
        rentals.append(rental)
    }
    public func getName() -> String {
        return name
    }

    public func statement() -> String {
        var totalAmount: Double = 0
        var frequentRenterPoints: Int = 0
        var result = "Rental Record for " + getName()

        rentals.forEach { each in
            // Remove usage
//            let thisAmount = amountFor(each)
            let thisAmount = each.getCharge()

            frequentRenterPoints += 1
            if ((each.getMovie().getPriceCode() == Movie.NEW_RELEASE) &&
                each.getDaysRented() > 1) {
                frequentRenterPoints += 1
            }

            result += "\t" + each.getMovie().getTitle() + "\t" + "\(thisAmount)" + "\n"

            totalAmount += thisAmount
        }
        result += "Amount owed is \(totalAmount) \n"
        result += "You earned \(frequentRenterPoints) frequent renter points"
        return result
    }

// All usages removed so delete
//    private func amountFor(_ aRental: Rental) -> Double {
//    }
}

//: [Next](@next)
