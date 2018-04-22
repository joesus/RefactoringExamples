import Foundation

public enum MovieFixtures {
    public static let regular: Movie = {
        return Movie(title: "Moon", priceCode: 0)
    }()
    public static let newRelease: Movie = {
        return Movie(title: "Apollo 14", priceCode: 1)
    }()
    public static let childrens: Movie = {
        return Movie(title: "GoNoodle or something", priceCode: 2)
    }()
}
