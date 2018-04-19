//: [Previous](@previous)

/*:
 ### Decomposing and Redistributing the Statement Method

 Redistributes the switch to its own method on the Customer class.
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
        return name;
    }

    public func statement() -> String {
        var totalAmount: Double = 0
        var frequentRenterPoints: Int = 0
        var result = "Rental Record for " + getName()

        rentals.forEach { each in
            // Uses new method code was abstracted into
            let thisAmount = amountFor(each)

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

    private func amountFor(_ each: Rental) -> Double {
        var thisAmount: Double = 0
        switch each.getMovie().getPriceCode() {
        case Movie.REGULAR:
            thisAmount += 2
            if each.getDaysRented() > 2 {
                thisAmount += Double(each.getDaysRented() - 2) * 1.5
            }
        case Movie.NEW_RELEASE:
            thisAmount += Double(each.getDaysRented()) * 3
        case Movie.CHILDRENS:
            thisAmount += 1.5
            if (each.getDaysRented() > 3) {
                thisAmount += Double(each.getDaysRented() - 3) * 1.5
            }
        default:
            break
        }
        return thisAmount
    }
}

//: [Next](@next)
