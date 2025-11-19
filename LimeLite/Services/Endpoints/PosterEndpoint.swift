import Foundation

enum PosterEndpoint: Endpoint {
    
    var path: String? {
        switch self {
        case .poster(let path):
            return "w300/" + path
        }
    }
    var httpMethod: HTTPMethod { .get }
    var baseRoute: BaseRoute { .image }
    var parameters: [String : Any] { [:] }
    
    case poster(path: String)
    
}

