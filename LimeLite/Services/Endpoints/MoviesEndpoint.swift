enum MoviesEndpoint: Endpoint {
    
    var httpMethod: HTTPMethod { .get }
    
    var path: String? {
        "movies/now_playing"
    }
    
    var parameters: [String : Any] {
        [:]
    }
    
    case recentMovies
    
}
