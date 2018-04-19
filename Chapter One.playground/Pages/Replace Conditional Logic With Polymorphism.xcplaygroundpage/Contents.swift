//: [Previous](@previous)

/*:
 ### Move logic that belongs on movie back into movie.

 The code smell was the switching on another class's enum.
 This will make it easier to have subclasses for movie with different charge methods for the different types of films.
 */

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

    // This is better because days rented does not vary based on the type of movie
    // however the charge does vary based on the type of movie.
    public func getCharge() -> Double {
        return movie.getCharge(daysRented: daysRented)
    }

    public func getFrequentRenterPoints() -> Int {
        return movie.getFrequentRenterPoints(daysRented: daysRented)
    }
}

public class Movie {
    public static let CHILDRENS = 2
    public static let REGULAR = 0
    public static let NEW_RELEASE = 1

    private var title: String
    private var priceCode: Int

    public init(title: String, priceCode: Int) {
        self.title = title
        self.priceCode = priceCode
    }
    public func getPriceCode() -> Int {
        return priceCode
    }
    public func setPriceCode(value: Int) {
        priceCode = value
    }
    public func getTitle() -> String {
        return title
    }

    func getCharge(daysRented: Int) -> Double {
        var result = 0.0
        switch getPriceCode() {
        case Movie.REGULAR:
            result += 2
            if daysRented > 2 {
                result += Double(daysRented - 2) * 1.5
            }
        case Movie.NEW_RELEASE:
            result += Double(daysRented) * 3
        case Movie.CHILDRENS:
            result += 1.5
            if daysRented > 3 {
                result += Double(daysRented - 3) * 1.5
            }
        default:
            break
        }
        return result
    }

    func getFrequentRenterPoints(daysRented: Int) -> Int {
        if priceCode == Movie.NEW_RELEASE,
            daysRented > 1 {
            return 2
        } else {
            return 1
        }
    }
 }


//: [Next](@next)
