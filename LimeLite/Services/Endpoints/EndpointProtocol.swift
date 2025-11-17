import Foundation

enum HTTPMethod: String {
    case get, post
    
    var value: String { rawValue.uppercased() }
}

protocol Endpoint {
    var httpMethod: HTTPMethod { get }
    var path: String? { get }
    var parameters: [String: Any] { get }
}
