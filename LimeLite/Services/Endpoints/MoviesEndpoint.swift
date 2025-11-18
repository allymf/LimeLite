enum MoviesEndpoint: Endpoint {
    
    var httpMethod: HTTPMethod { .get }
    var baseRoute: BaseRoute { .data }
    
    var path: String? {
        "movie/now_playing"
    }
    
    var parameters: [String : Any] {
        [:]
    }
    
    case recentMovies
    
}
