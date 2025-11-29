enum MoviesEndpoint: Endpoint {
    
    var httpMethod: HTTPMethod { .get }
    var baseRoute: BaseRoute { .data }
    
    var path: String? {
        switch self {
        case .recentMovies:
            return "movie/now_playing"
        case .details(let id):
            return "movie/\(id)"
        }
    }
    
    var parameters: [String : Any] {
        [:]
    }
    
    case recentMovies
    case details(id: String)
    
}
