import SwiftUI

struct MovieCardView: View {
    
    private let service = NetworkService()
    
    @State private var posterImage: UIImage?
    let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    var body: some View {
        VStack {
            
            if let posterImage {
                Image(uiImage: posterImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                ProgressView()
            }
            
            Spacer()
            Text(movie.title)
                .lineLimit(1)
        }
        .frame(width: 110, height: 170)
        .task {
            await getImage()
        }
    }
    
    private func getImage() async {
        do {
            let imageData = try await service.requestData(for: PosterEndpoint.poster(path: movie.posterPath))
            
            posterImage = UIImage(data: imageData)
        } catch {
            print(error.localizedDescription)
        }
    }
}
