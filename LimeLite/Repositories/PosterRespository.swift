import Foundation
import UIKit

protocol PosterRespositoryProtocol {
    func fetchPosterImageData(from posterPath: String) async throws -> UIImage?
}

final class PosterRespository: PosterRespositoryProtocol {
    
    private let service: NetworkServiceProtocol
    private let imageCacheRepository: ImageCacheRepositoryProtocol
    
    init(
        service: NetworkServiceProtocol = NetworkService(),
        imageCacheRepository: ImageCacheRepositoryProtocol = ImageCacheRepository.shared
    ) {
        self.service = service
        self.imageCacheRepository = imageCacheRepository
    }
    
    func fetchPosterImageData(from posterPath: String) async throws -> UIImage? {
        if let cachedImage = imageCacheRepository.getImage(fromKey: posterPath) {
            return cachedImage
        }
        
        let imageData = try await service.requestData(for: PosterEndpoint.poster(path: posterPath))
        
        guard let image = UIImage(data: imageData) else {
            return nil
        }
        
        imageCacheRepository.setImage(
            image,
            forKey: posterPath
        )
        
        return image
    }
    
}
