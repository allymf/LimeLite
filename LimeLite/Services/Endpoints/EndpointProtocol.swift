import Foundation

enum HTTPMethod: String {
    case get, post
    
    var value: String { rawValue.uppercased() }
}

enum BaseRoute {
    case image, data
}

protocol EndpointProtocol {
    var baseRoute: BaseRoute { get }
    var httpMethod: HTTPMethod { get }
    var parameters: [String: Any] { get }
}
