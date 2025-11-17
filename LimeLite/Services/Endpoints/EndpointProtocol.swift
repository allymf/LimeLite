import Foundation

enum HTTPMethod: String {
    case get, post
    
    var value: String { rawValue.uppercased() }
}

enum BaseRoute {
    case image, data
}

enum ConfigKeys: String {
    case imagePath
}

protocol EnvironmentProvider {
    func resolveBasePath(for baseRoute: BaseRoute)-> String?
    func fetchAPIKey() -> String?
}

protocol EndpointProtocol {
    var url: URL? { get }
    var baseRoute: BaseRoute { get }
    var httpMethod: HTTPMethod { get }
    var parameters: [String: Any] { get }
}
