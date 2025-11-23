import Foundation
import UIKit

protocol ImageCacheRepositoryProtocol {
    func setImage(_ image: UIImage, forKey key: String)
    func getImage(fromKey key: String) -> UIImage?
    func deleteImage(fromKey key: String)
    func clearOutCache()
}

final class ImageCacheRepository: ImageCacheRepositoryProtocol {
    
    static let shared = ImageCacheRepository()
    
    private let imageCache = NSCache<NSString, UIImage>()
    
    func setImage(_ image: UIImage, forKey key: String) {
        imageCache.setObject(image, forKey: key as NSString)
        debugPrint("Image cached for key: ", key)
    }
    
    func getImage(fromKey key: String) -> UIImage? {
        debugPrint("Retrieved cached image for key: ", key)
        return imageCache.object(forKey: key as NSString)
    }
    
    func deleteImage(fromKey key: String) {
        imageCache.removeObject(forKey: key as NSString)
        debugPrint("Removed image for key: ", key)
    }
    
    func clearOutCache() {
        imageCache.removeAllObjects()
        debugPrint("Cache cleared!")
    }
    
}
