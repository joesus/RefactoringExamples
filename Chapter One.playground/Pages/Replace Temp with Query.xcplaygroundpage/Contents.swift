//: [Previous](@previous)

/*:
 ### Replace Temp With Query

 Replace temporary variable with direct calls where possible

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
//            Replace the temporary assignment
//            let thisAmount = each.getCharge()

            frequentRenterPoints += 1
            if ((each.getMovie().getPriceCode() == Movie.NEW_RELEASE) &&
                each.getDaysRented() > 1) {
                frequentRenterPoints += 1
            }

            result += "\t" + each.getMovie().getTitle() + "\t" + "\(each.getCharge())" + "\n"

            totalAmount += each.getCharge()
        }
        result += "Amount owed is \(totalAmount) \n"
        result += "You earned \(frequentRenterPoints) frequent renter points"
        return result
    }
}

//: [Next](@next)
