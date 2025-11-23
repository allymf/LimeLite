import Foundation

struct Movie: Decodable, Identifiable, Hashable {
    enum CodingKeys: String, CodingKey {
        case title, posterPath = "poster_path"
    }
    
    let id: UUID = UUID()
    let title: String
    let posterPath: String
}
