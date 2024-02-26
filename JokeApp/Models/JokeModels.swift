import Foundation

class Joke: Codable {
    var category: String
    var setup: String
    var delivery: String
}

enum JokeError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}
