import SwiftUI

enum Destination: Hashable {
    case movieDetails(movie: Movie)
}

struct DiscoverMoviesView: View {
    
    let service = NetworkService()
    
    @State private var response = RecentMoviesResponse(results: [])
    @State private var isLoading = false
    @State private var errorMessage: String?
    
    @State private var path = [Destination]()
    
    private let columns = [
        GridItem(.flexible(minimum: 100, maximum: 200)),
        GridItem(.flexible(minimum: 100, maximum: 200)),
        GridItem(.flexible(minimum: 100, maximum: 200))
    ]
    
    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    if let errorMessage {
                        Text("error: \(errorMessage)")
                    }
                    
                    ForEach(response.results) { movie in
                        MovieCardView(movie: movie)
                            .onTapGesture {
                                path.append(.movieDetails(movie: movie))
                                print("Tapped movie", movie)
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
                    if isLoading {
                        ProgressView("Fetching Data...")
                    }
                }
                .task {
                    await doRequest()
                }
            }
        }
    }
    
    func doRequest() async {
        isLoading = true
        do {
            response = try await service.request(for: MoviesEndpoint.recentMovies)
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    
}

#Preview {
    DiscoverMoviesView()
}
