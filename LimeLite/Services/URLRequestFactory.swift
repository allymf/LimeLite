import Foundation

protocol URLRequestFactoryProtocol {
    func makeRequest(from endpoint: EndpointProtocol) throws -> URLRequest
}

struct URLRequestFactory: URLRequestFactoryProtocol {
    
    private enum InfoKeys {
        static let data = "BASE_DATA_API"
        static let image = "BASE_IMAGE_API"
    }
    
    private enum DefaultRequestParameters {
        static let apiKey = "apikey"
    }
    
    private let bundle: Bundle
    
    private var infoDictionary: [String : Any]? { bundle.infoDictionary }
    
    private var apiKey: String? {
        infoDictionary?[DefaultRequestParameters.apiKey] as? String
    }
    
    init(bundle: Bundle = .main) {
        self.bundle = bundle
    }
    
    func makeRequest(from endpoint: EndpointProtocol) throws -> URLRequest {
        guard let urlText = resolveText(for: endpoint.baseRoute),
                let baseURL = URL(string: urlText) else {
            throw NetworkError.invalidURL
        }
        
        var parameters = endpoint.parameters
        parameters[DefaultRequestParameters.apiKey] = apiKey
        
        guard let urlWithParamteres = baseURL.appendingParameters(parameters) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: urlWithParamteres)
        request.httpMethod = endpoint.httpMethod.value
        
        return request
    }
    
    private func resolveText(for route: BaseRoute) -> String? {
        switch route {
        case .data:
            return infoDictionary?[InfoKeys.data] as? String
        case .image:
            return infoDictionary?[InfoKeys.image] as? String
        }
    }
    
}
