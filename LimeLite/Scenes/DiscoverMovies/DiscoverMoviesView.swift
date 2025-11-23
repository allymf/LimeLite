import SwiftUI

enum Destination: Hashable {
    case movieDetails(movie: Movie)
}

struct DiscoverMoviesView: View {
    
    @State private var viewModel = DiscoverMoviesViewModel()
    
    private let columns = [
        GridItem(.flexible(minimum: 100, maximum: 200)),
        GridItem(.flexible(minimum: 100, maximum: 200)),
        GridItem(.flexible(minimum: 100, maximum: 200))
    ]
    
    var body: some View {
        NavigationStack(path: $viewModel.path) {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    if let errorMessage = viewModel.errorMessage {
                        Text("error: \(errorMessage)")
                    }
                    
                    ForEach(viewModel.response.results) { movie in
                        MovieCardView(viewModel: MovieCardViewModel(movie: movie))
                            .onTapGesture {
                                viewModel.didTapMovie(movie)
                            }
                    }
                    
                }
                .padding(16)
                .navigationTitle("Discover")
                .navigationDestination(for: Destination.self) { destination in
                    switch destination {
                    case .movieDetails(let movie):
                        MovieDetailsView(movie: movie)
                    }
                    
                }
                .overlay {
                    if viewModel.isLoading {
                        ProgressView("Fetching Data...")
                    }
                }
                .task {
                    await viewModel.fetchMovies()
                }
            }
            .refreshable {
                await viewModel.fetchMovies()
            }
        }
    }
    
}

#Preview {
    DiscoverMoviesView()
}
