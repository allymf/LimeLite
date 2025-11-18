import SwiftUI

struct MovieCardView: View {
    
    private let service = NetworkService()
    
    @State private var posterImage = Image(uiImage: .actions)
    let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    var body: some View {
        VStack {
            posterImage
            Text(movie.title)
        }
        .task {
            await getImage()
        }
    }
    
    private func getImage() async {
        do {
            let imageData = try await service.requestData(for: PosterEndpoint.poster(path: movie.posterPath))
            
            posterImage = Image(uiImage: UIImage(data: imageData) ?? .init())
        } catch {
            print(error.localizedDescription)
        }
    }
}
