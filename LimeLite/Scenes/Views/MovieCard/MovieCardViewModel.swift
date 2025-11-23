import SwiftUI
import UIKit

@Observable
final class MovieCardViewModel {
    
    private let posterRepository: PosterRespositoryProtocol
    private let movie: Movie
    
    var title: String { movie.title }
    private(set) var posterImage: UIImage?
    private(set) var isLoading: Bool = false
    
    init(
        posterRepository: PosterRespositoryProtocol = PosterRespository(),
        movie: Movie
    ) {
        self.posterRepository = posterRepository
        self.movie = movie
    }
    
    func fetchPosterImage() async {
        isLoading = true
        do {
            posterImage = try await posterRepository.fetchPosterImageData(from: movie.posterPath)
        } catch {
            debugPrint("Error while fetching poster image: ", error.localizedDescription)
        }
        isLoading = false
    }
    
}
