import Foundation

struct Movie: Decodable, Identifiable {
    enum CodingKeys: String, CodingKey {
        case title, posterPath = "poster_path"
    }
    
    let id: UUID = UUID()
    let title: String
    let posterPath: String
}
