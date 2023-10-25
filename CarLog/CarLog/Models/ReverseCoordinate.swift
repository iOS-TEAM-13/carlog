import Foundation

struct ReverseCoordinate: Codable {
    let reverseCoordinate: ReverseCoordinateClass
}

struct ReverseCoordinateClass: Codable {
    let lat, lon: String
}
