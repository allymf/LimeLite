enum NetworkError: Error {
    case invalidURL
    case requestError(Error)
    case invalidResponse(statusCode: Int)
    case decodingError(Error)
}
