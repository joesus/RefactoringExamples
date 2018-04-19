import Foundation

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
}

