import Foundation

enum HTTPMethod: String {
    case get, post
    
    var value: String { rawValue.uppercased() }
}

enum BaseRoute {
    case data, image
}

protocol Endpoint {
    var httpMethod: HTTPMethod { get }
    var baseRoute: BaseRoute { get }
    var path: String? { get }
    var parameters: [String: Any] { get }
}
