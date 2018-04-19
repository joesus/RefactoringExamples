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
}
