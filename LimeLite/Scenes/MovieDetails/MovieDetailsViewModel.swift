import SwiftUI

@Observable
final class MovieDetailsViewModel {
    
    private let posterRepository: PosterRespositoryProtocol
    private let movie: Movie
    
    var title: String { movie.title }
    
    init(
        posterRepository: PosterRespositoryProtocol = PosterRespository(),
        movie: Movie
    ) {
        self.posterRepository = posterRepository
        self.movie = movie
    }
    
}
