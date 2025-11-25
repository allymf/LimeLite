import SwiftUI

struct MovieCardView: View {
    
    @State var viewModel: MovieCardViewModeling
    
    var body: some View {
        VStack {
            
            if let posterImage = viewModel.posterImage {
                Image(uiImage: posterImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                Image(systemName: "photo.artframe")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            
            Spacer()
            Text(viewModel.title)
                .lineLimit(1)
        }
        .frame(width: 110, height: 170)
        .overlay {
            if viewModel.isLoading {
                ProgressView()
            }
        }
        .task {
            await viewModel.fetchPosterImage()
        }
    }
    
}

#if DEBUG
    struct PreviewMovieCardViewModel: MovieCardViewModeling {
        let title: String
        var posterImage: UIImage?
        var isLoading: Bool
        
        func fetchPosterImage() async {}
    }
#endif

#Preview {
    @Previewable @State var viewModel = PreviewMovieCardViewModel(
        title: "1234",
        posterImage: .init(),
        isLoading: false
    )
    
    MovieCardView(viewModel: viewModel)
}
