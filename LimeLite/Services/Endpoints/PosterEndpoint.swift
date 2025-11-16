enum PosterEndpoint: EndpointProtocol {
    var url: URL? { nil }
    
    var httpMethod: HTTPMethod { .get }
    
}
