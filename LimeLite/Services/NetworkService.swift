import Foundation

protocol NetworkServiceProtocol {
    func performRequest<T: Decodable>(for endpoint: Endpoint) async throws -> T
    func performRequest(for endpoint: Endpoint) async throws -> Data
}

final class NetworkService: NetworkServiceProtocol {
    
    private let urlSession: URLSession
    private let urlRequestFactory: URLRequestFactoryProtocol
    private let decoder: JSONDecoder
    
    init(
        urlSession: URLSession = URLSession.shared,
        urlRequestFactory: URLRequestFactoryProtocol,
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.urlSession = urlSession
        self.urlRequestFactory = urlRequestFactory
        self.decoder = decoder
    }
    
    func performRequest(for endpoint: Endpoint) async throws -> Data {
        let request = try urlRequestFactory.makeRequest(from: endpoint)
        
        let (data, response): (Data, URLResponse)
        
        do {
            (data, response) = try await urlSession.data(for: request)
        } catch {
            throw NetworkError.requestError(error)
        }
        
        let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
        
        guard (200...299).contains(statusCode) else {
            throw NetworkError.invalidResponse(statusCode: statusCode)
        }
        
        return data
    }
    
    func performRequest<T: Decodable>(for endpoint: Endpoint) async throws -> T {
        let data = try await performRequest(for: endpoint)
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
    
}
