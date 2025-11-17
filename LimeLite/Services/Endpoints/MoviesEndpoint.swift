enum MoviesEndpoint: Endpoint {
    
    var httpMethod: HTTPMethod { .get }
    
    var parameters: [String : Any] {
        switch self {
        case .movieDetails(let id):
            ["i": id]
        case .movies(let title):
            ["t": title]
        case .searchMovies:
            [:]
        }
        
    }
    
    case movieDetails(id: String)
    case movies(title: String)
    case searchMovies
    
    
}
