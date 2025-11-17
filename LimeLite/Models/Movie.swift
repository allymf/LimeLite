import Foundation

struct Movie: Decodable, Identifiable {
    enum CodingKeys: CodingKey {
        case title
    }
    
    let id: UUID
    let title: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = UUID()
        title = try container.decode(String.self, forKey: .title)
    }
}
