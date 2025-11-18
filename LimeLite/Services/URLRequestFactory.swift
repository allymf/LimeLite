import Foundation

protocol URLRequestFactoryProtocol {
    func makeRequest(from endpoint: Endpoint) throws -> URLRequest
}

struct URLRequestFactory: URLRequestFactoryProtocol {
    
    private enum InfoKeys {
        static let baseURL = "BASE_URL"
        static let baseImageURL = "BASE_IMAGE_URL"
        static let apiToken = "API_TOKEN"
    }
    
    private let bundle: Bundle
    
    private var infoDictionary: [String : Any]? { bundle.infoDictionary }
    
    private var baseURLText: String? {
        infoDictionary?[InfoKeys.baseURL] as? String
    }
    
    private var baseImageURLText: String? {
        infoDictionary?[InfoKeys.baseImageURL] as? String
    }
    
    private var apiToken: String? {
        infoDictionary?[InfoKeys.apiToken] as? String
    }
    
    init(bundle: Bundle = .main) {
        self.bundle = bundle
    }
    
    func makeRequest(from endpoint: Endpoint) throws -> URLRequest {
        guard let urlText = resolveBaseURLText(for: endpoint.baseRoute),
                var baseURL = URL(string: urlText) else {
            throw NetworkError.invalidURL
        }
        
        baseURL = baseURL.appending(path: endpoint.path ?? "")
        
        guard let urlWithParamteres = baseURL.appendingParameters(endpoint.parameters) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: urlWithParamteres)
        request.httpMethod = endpoint.httpMethod.value
        request.setValue(
            "Bearer \(apiToken ?? "")",
            forHTTPHeaderField: "Authorization"
        )
        
        return request
    }
    
    private func resolveBaseURLText(for baseRoute: BaseRoute) -> String? {
        switch baseRoute {
        case .data:
            return baseURLText
        case .image:
            return baseImageURLText
        }
    }
    
}
