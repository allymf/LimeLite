import Foundation

enum HTTPMethod: String {
    case get, post
    
    var value: String { rawValue.uppercased() }
}

protocol EndpointProtocol {
    var url: URL? { get }
    var httpMethod: HTTPMethod { get }
}
