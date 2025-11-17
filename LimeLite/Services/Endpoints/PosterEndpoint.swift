import Foundation

struct PosterEndpoint: Endpoint {
    
    var baseRoute: BaseRoute { .image }
    var httpMethod: HTTPMethod { .get }
    var parameters: [String : Any] {
        ["i": parameterValues.id]
    }
    
    private let parameterValues: PosterEndpointParameters
    
    init(parameterValues: PosterEndpointParameters) {
        self.parameterValues = parameterValues
    }
    
}

struct PosterEndpointParameters {
    let id: String
}
