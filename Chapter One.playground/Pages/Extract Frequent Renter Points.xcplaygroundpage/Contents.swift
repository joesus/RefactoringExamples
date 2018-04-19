//: [Previous](@previous)

/*:
 ### Extract Frequent Renter Points

 Use the extract method on frequent renter points. Put it on the correct object - the Rental itself.

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
            frequentRenterPoints += each.getFrequentRenterPoints()
//            frequentRenterPoints += 1
//            if ((each.getMovie().getPriceCode() == Movie.NEW_RELEASE) &&
//                each.getDaysRented() > 1) {
//                frequentRenterPoints += 1
//            }

            result += "\t" + each.getMovie().getTitle() + "\t" + "\(each.getCharge())" + "\n"

            totalAmount += each.getCharge()
        }
        result += "Amount owed is \(totalAmount) \n"
        result += "You earned \(frequentRenterPoints) frequent renter points"
        return result
    }
}

public class Rental {
    private let movie: Movie
    private let daysRented: Int

    public init(movie: Movie, daysRented: Int) {
        self.movie = movie
        self.daysRented = daysRented
    }
    public func getDaysRented() -> Int {
        return daysRented
    }
    public func getMovie() -> Movie {
        return movie
    }
    public func getCharge() -> Double {
        var result: Double = 0
        switch getMovie().getPriceCode() {
        case Movie.REGULAR:
            result += 2
            if getDaysRented() > 2 {
                result += Double(getDaysRented() - 2) * 1.5
            }
        case Movie.NEW_RELEASE:
            result += Double(getDaysRented()) * 3
        case Movie.CHILDRENS:
            result += 1.5
            if (getDaysRented() > 3) {
                result += Double(getDaysRented() - 3) * 1.5
            }
        default:
            break
        }
        return result
    }

    public func getFrequentRenterPoints() -> Int {
        if ((getMovie().getPriceCode() == Movie.NEW_RELEASE) &&
            getDaysRented() > 1) {
            return 2
        } else {
            return 1
        }

    }
}


//: [Next](@next)
