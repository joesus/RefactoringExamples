//: [Previous](@previous)

/*:
 ### Replace Temporary Variables

 Remove the totalAmount temporary assignment by creating a 'getTotalCharge' method.
 Remove the frequentRenterPoints temporary assignment by create a 'getTotalFrequentRenterPoints' method.

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
        var result = "Rental Record for " + getName()

        rentals.forEach { each in
            result += "\t" + each.getMovie().getTitle() + "\t" + "\(each.getCharge())" + "\n"
        }

        result += "Amount owed is \(getTotalCharge()) \n"
        result += "You earned \(getTotalFrequentRenterPoints()) frequent renter points"
        return result
    }

    func getTotalCharge() -> Double {
        var result = 0
        rentals.forEach { each in
            result += each.getCharge()
        }
        return result
    }

    func getTotalFrequentRenterPoints() -> Int {
        var result = 0
        rentals.forEach { each in
            result += each.getFrequentRenterPoints()
        }
        return result
    }
}

//: [Next](@next)
