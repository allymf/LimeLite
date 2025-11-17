import Foundation

enum PosterEndpoint: EndpointProtocol {
    var url: URL? { nil }
    var baseRoute: BaseRoute { .data }
    var httpMethod: HTTPMethod { .get }
    
}
