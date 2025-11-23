import SwiftUI

struct MovieDetailsView: View {
    
    private let viewModel: MovieDetailsViewModel
    
    init(viewModel: MovieDetailsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Text(viewModel.title)
            .navigationTitle(viewModel.title)
    }
}

#Preview {
    MovieDetailsView(viewModel: .init(movie: .init(title: "Movie title", posterPath: "")))
}
