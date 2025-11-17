import Foundation

struct Movie: Decodable, Identifiable {
    enum CodingKeys: CodingKey {
        case title
    }
    
    let id: UUID = UUID()
    let title: String
}
