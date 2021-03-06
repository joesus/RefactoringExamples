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
        var result = "Rental Record for \(getName())\n"

        rentals.forEach { each in
            frequentRenterPoints += each.getFrequentRenterPoints()
//            frequentRenterPoints += 1
//            if ((each.getMovie().getPriceCode() == Movie.NEW_RELEASE) &&
//                each.getDaysRented() > 1) {
//                frequentRenterPoints += 1
//            }

            result += "    " + each.getMovie().getTitle() + "    " + "\(each.getCharge())" + "\n"

            totalAmount += each.getCharge()
        }
        result += "Amount owed is \(totalAmount)\n"
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

//: Tests to make sure we haven't broken anything. They mention the need for these in the book but do not include a test suite so I wrote one.
//: Note: Modified the code to use spaces instead of tabs since it was easier than figuring out why multiline string literals weren't handling the tabs as expected.

import XCTest

class StatementTests: XCTestCase {

    let customer = Customer(name: "Joe")

    func testStatementWithNoRentals() {
        let expectedStatement = """
Rental Record for Joe
Amount owed is 0.0
You earned 0 frequent renter points
"""
        XCTAssertEqual(customer.statement(), expectedStatement)
    }

    // Regular Movie
    func testSingleRegularRentalSingleDay() {
        customer.addRental(rental: Rental(movie: MovieFixtures.regular, daysRented: 1))

        let expectedStatement = """
Rental Record for Joe
    Moon    2.0
Amount owed is 2.0
You earned 1 frequent renter points
"""
        XCTAssertEqual(customer.statement(), expectedStatement)
    }

    func testSingleRegularRentalMultipleDays() {
        customer.addRental(rental: Rental(movie: MovieFixtures.regular, daysRented: 3))

        let expectedStatement = """
Rental Record for Joe
    Moon    3.5
Amount owed is 3.5
You earned 1 frequent renter points
"""
        XCTAssertEqual(customer.statement(), expectedStatement)
    }

    func testMultipleRegularRentalsSingleDay() {
        customer.addRental(rental: Rental(movie: MovieFixtures.regular, daysRented: 1))
        customer.addRental(rental: Rental(movie: MovieFixtures.regular, daysRented: 1))
        customer.addRental(rental: Rental(movie: MovieFixtures.regular, daysRented: 1))

        let expectedStatement = """
Rental Record for Joe
    Moon    2.0
    Moon    2.0
    Moon    2.0
Amount owed is 6.0
You earned 3 frequent renter points
"""
        XCTAssertEqual(customer.statement(), expectedStatement)
    }

    func testMultipleRegularRentalsMultipleDays() {
        customer.addRental(rental: Rental(movie: MovieFixtures.regular, daysRented: 3))
        customer.addRental(rental: Rental(movie: MovieFixtures.regular, daysRented: 3))
        customer.addRental(rental: Rental(movie: MovieFixtures.regular, daysRented: 3))

        let expectedStatement = """
Rental Record for Joe
    Moon    3.5
    Moon    3.5
    Moon    3.5
Amount owed is 10.5
You earned 3 frequent renter points
"""
        XCTAssertEqual(customer.statement(), expectedStatement)
    }

    // New Release Movie
    func testSingleNewReleaseRentalSingleDay() {
        customer.addRental(rental: Rental(movie: MovieFixtures.newRelease, daysRented: 1))

        let expectedStatement = """
Rental Record for Joe
    Apollo 14    3.0
Amount owed is 3.0
You earned 1 frequent renter points
"""
        XCTAssertEqual(customer.statement(), expectedStatement)
    }

    func testSingleNewReleaseRentalMultipleDays() {
        customer.addRental(rental: Rental(movie: MovieFixtures.newRelease, daysRented: 3))

        let expectedStatement = """
Rental Record for Joe
    Apollo 14    9.0
Amount owed is 9.0
You earned 2 frequent renter points
"""
        XCTAssertEqual(customer.statement(), expectedStatement)
    }

    func testMultipleNewReleaseRentalsSingleDay() {
        customer.addRental(rental: Rental(movie: MovieFixtures.newRelease, daysRented: 1))
        customer.addRental(rental: Rental(movie: MovieFixtures.newRelease, daysRented: 1))
        customer.addRental(rental: Rental(movie: MovieFixtures.newRelease, daysRented: 1))

        let expectedStatement = """
Rental Record for Joe
    Apollo 14    3.0
    Apollo 14    3.0
    Apollo 14    3.0
Amount owed is 9.0
You earned 3 frequent renter points
"""
        XCTAssertEqual(customer.statement(), expectedStatement)
    }

    func testMultipleNewReleaseRentalsMultipleDays() {
        customer.addRental(rental: Rental(movie: MovieFixtures.newRelease, daysRented: 3))
        customer.addRental(rental: Rental(movie: MovieFixtures.newRelease, daysRented: 3))
        customer.addRental(rental: Rental(movie: MovieFixtures.newRelease, daysRented: 3))

        let expectedStatement = """
Rental Record for Joe
    Apollo 14    9.0
    Apollo 14    9.0
    Apollo 14    9.0
Amount owed is 27.0
You earned 6 frequent renter points
"""
        XCTAssertEqual(customer.statement(), expectedStatement)
    }

    // Childrens' Movie
    func testSingleChildrensRentalSingleDay() {
        customer.addRental(rental: Rental(movie: MovieFixtures.childrens, daysRented: 1))

        let expectedStatement = """
Rental Record for Joe
    GoNoodle or something    1.5
Amount owed is 1.5
You earned 1 frequent renter points
"""
        XCTAssertEqual(customer.statement(), expectedStatement)

    }

    func testSingleChildrensRentalMultipleDays() {
        customer.addRental(rental: Rental(movie: MovieFixtures.childrens, daysRented: 5))

        let expectedStatement = """
Rental Record for Joe
    GoNoodle or something    4.5
Amount owed is 4.5
You earned 1 frequent renter points
"""
        XCTAssertEqual(customer.statement(), expectedStatement)
    }

    func testMultipleChildrensRentalsSingleDay() {
        customer.addRental(rental: Rental(movie: MovieFixtures.childrens, daysRented: 1))
        customer.addRental(rental: Rental(movie: MovieFixtures.childrens, daysRented: 1))
        customer.addRental(rental: Rental(movie: MovieFixtures.childrens, daysRented: 1))

        let expectedStatement = """
Rental Record for Joe
    GoNoodle or something    1.5
    GoNoodle or something    1.5
    GoNoodle or something    1.5
Amount owed is 4.5
You earned 3 frequent renter points
"""
        XCTAssertEqual(customer.statement(), expectedStatement)
    }

    func testMultipleChildrensRentalsMultipleDays() {
        customer.addRental(rental: Rental(movie: MovieFixtures.childrens, daysRented: 5))
        customer.addRental(rental: Rental(movie: MovieFixtures.childrens, daysRented: 5))
        customer.addRental(rental: Rental(movie: MovieFixtures.childrens, daysRented: 5))

        let expectedStatement = """
Rental Record for Joe
    GoNoodle or something    4.5
    GoNoodle or something    4.5
    GoNoodle or something    4.5
Amount owed is 13.5
You earned 3 frequent renter points
"""
        XCTAssertEqual(customer.statement(), expectedStatement)
    }

    // Mixture of Movies
    func testMultipleMovieTypesSingleDay() {
        customer.addRental(rental: Rental(movie: MovieFixtures.regular, daysRented: 1))
        customer.addRental(rental: Rental(movie: MovieFixtures.newRelease, daysRented: 1))
        customer.addRental(rental: Rental(movie: MovieFixtures.childrens, daysRented: 1))

        let expectedStatement = """
Rental Record for Joe
    Moon    2.0
    Apollo 14    3.0
    GoNoodle or something    1.5
Amount owed is 6.5
You earned 3 frequent renter points
"""
        XCTAssertEqual(customer.statement(), expectedStatement)
    }

    func testMultipleMovieTypesMultipleDays() {
        customer.addRental(rental: Rental(movie: MovieFixtures.regular, daysRented: 6))
        customer.addRental(rental: Rental(movie: MovieFixtures.newRelease, daysRented: 4))
        customer.addRental(rental: Rental(movie: MovieFixtures.childrens, daysRented: 7))

        let expectedStatement = """
Rental Record for Joe
    Moon    8.0
    Apollo 14    12.0
    GoNoodle or something    7.5
Amount owed is 27.5
You earned 4 frequent renter points
"""
        XCTAssertEqual(customer.statement(), expectedStatement)
    }
}

class TestObserver: NSObject, XCTestObservation {
    func testCase(_ testCase: XCTestCase,
                  didFailWithDescription description: String,
                  inFile filePath: String?,
                  atLine lineNumber: Int) {
        assertionFailure(description, line: UInt(lineNumber))
    }
}

let testObserver = TestObserver()
XCTestObservationCenter.shared.addTestObserver(testObserver)

StatementTests.defaultTestSuite.run()
