//: [Previous](@previous)

/*:
 ### Add New Functionality
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

    public func htmlStatement() -> String {
        var result = "<H1>Rentals for <EM>" + getName() + "</EM></H1><P>\n"
        rentals.forEach { rental in
            //show figures for each rental
            result += "\(rental.getMovie().getTitle()): \(rental.getCharge()) <BR>\n"
        }
        //add footer lines
        result +=  "<P>You owe <EM>\(getTotalCharge())</EM><P>\n"
        result += "On this rental you earned <EM>\(getTotalFrequentRenterPoints())</EM> frequent renter points<P>"
        return result
    }

    func getTotalCharge() -> Double {
        var result = 0.0
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
