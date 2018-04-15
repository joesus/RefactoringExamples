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
}

extension Customer {
    public func statement() -> String {
        var totalAmount: Double = 0
        var frequentRenterPoints: Int = 0
        var result = "Rental Record for " + getName()

        rentals.forEach { rental in
            var thisAmount: Double = 0

            switch rental.getMovie().getPriceCode() {
            case Movie.REGULAR:
                thisAmount += 2
                if rental.getDaysRented() > 2 {
                    thisAmount += Double(rental.getDaysRented() - 2) * 1.5
                }
            case Movie.NEW_RELEASE:
                thisAmount += Double(rental.getDaysRented()) * 3
            case Movie.CHILDRENS:
                thisAmount += 1.5
                if (rental.getDaysRented() > 3) {
                    thisAmount += Double(rental.getDaysRented() - 3) * 1.5
                }
            default:
                break
            }
            // add frequent renter points
            frequentRenterPoints += 1
            // add bonus for a two day new release rental
            if ((rental.getMovie().getPriceCode() == Movie.NEW_RELEASE) &&
                rental.getDaysRented() > 1) {
                frequentRenterPoints += 1
            }

            //show figures for this rental
            result += "\t" + rental.getMovie().getTitle() + "\t" + "\(thisAmount)" + "\n"

            totalAmount += thisAmount
        }
        //add footer lines
        result += "Amount owed is \(totalAmount) \n"
        result += "You earned \(frequentRenterPoints) frequent renter points"
        return result
    }
}