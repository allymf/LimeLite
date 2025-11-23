import SwiftUI

@Observable
final class DiscoverMoviesViewModel {
    
    private let service: NetworkServiceProtocol
    
    private(set) var response = RecentMoviesResponse(results: [])
    private(set) var isLoading = false
    private(set) var errorMessage: String?
    
    var path = [Destination]()
    
    init(service: NetworkServiceProtocol = NetworkService()) {
        self.service = service
    }
    
    func fetchMovies() async {
        isLoading = true
        do {
            response = try await service.request(for: MoviesEndpoint.recentMovies)
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    
    func didTapMovie(_ movie: Movie) {
        path.append(.movieDetails(movie: movie))
        print("Tapped movie", movie)
    }
    
}
