import Foundation

extension URL {
    func appendingParameters(_ parameters: [String: Any]) -> URL? {
        guard var urlComponents = URLComponents(
            url: self,
            resolvingAgainstBaseURL: true
        ) else { return nil }
        
        var queryItems: [URLQueryItem] = urlComponents.queryItems ?? []
        
        for (key, value) in parameters {
            let convertedValue = String(describing: value)
            let newQueryItem = URLQueryItem(
                name: key,
                value: convertedValue
            )
            queryItems.append(newQueryItem)
        }
        
        urlComponents.queryItems = queryItems.isEmpty ? nil : queryItems
        
        return urlComponents.url
    }
}
