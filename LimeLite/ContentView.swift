import SwiftUI

struct ContentView: View {
    
    let service = NetworkService()
    
    @State private var response = RecentMoviesResponse(results: [])
    @State private var isLoading = false
    @State private var errorMessage: String?
    
    private let columns = [
        GridItem(.flexible(minimum: 100, maximum: 200)),
        GridItem(.flexible(minimum: 100, maximum: 200)),
        GridItem(.flexible(minimum: 100, maximum: 200))
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    if let errorMessage {
                        Text("error: \(errorMessage)")
                    }
                    
                    ForEach(response.results) { movie in
                        MovieCardView(movie: movie)
                    }
                    
                }
                .padding(16)
                .navigationTitle("Discover")
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
    ContentView()
}
