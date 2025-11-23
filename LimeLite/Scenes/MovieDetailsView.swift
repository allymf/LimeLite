import SwiftUI

struct MovieDetailsView: View {
    
    let movie: Movie
    
    var body: some View {
        Text(movie.title)
            .navigationTitle(movie.title)
    }
}

#Preview {
    MovieDetailsView(movie: .init(title: "Movie Title", posterPath: ""))
}
