import Foundation

class Joke: Codable {
    var id: Int
    var category: String
    var setup: String
    var delivery: String
}

enum JokeError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}
