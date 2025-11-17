import SwiftUI

struct ContentView: View {
    
    let service = NetworkService()
    
    @State private var response = RecentMoviesResponse(results: [])
    @State private var isLoading = false
    @State private var errorMessage: String?
    
    var body: some View {
        NavigationView {
            List {
                if let errorMessage {
                    Text("error: \(errorMessage)")
                }
                
                ForEach(response.results) { movie in
                    Text("Movie: \(movie.title)")
                }
                
            }
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
