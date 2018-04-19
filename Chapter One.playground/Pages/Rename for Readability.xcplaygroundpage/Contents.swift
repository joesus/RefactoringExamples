//: [Previous](@previous)

/*:
 ### Renaming

 Renames the variables in amount(for:) method to be more readable.
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

    private func amountFor(_ aRental: Rental) -> Double {
        var result: Double = 0
        switch aRental.getMovie().getPriceCode() {
        case Movie.REGULAR:
            result += 2
            if aRental.getDaysRented() > 2 {
                result += Double(aRental.getDaysRented() - 2) * 1.5
            }
        case Movie.NEW_RELEASE:
            result += Double(aRental.getDaysRented()) * 3
        case Movie.CHILDRENS:
            result += 1.5
            if (aRental.getDaysRented() > 3) {
                result += Double(aRental.getDaysRented() - 3) * 1.5
            }
        default:
            break
        }
        return result
    }
}

//: [Next](@next)
