import Foundation

struct PosterEndpoint: Endpoint {
    var path: String? { nil }
    
    
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
