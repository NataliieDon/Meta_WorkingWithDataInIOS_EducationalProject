import Foundation
import CoreData

struct JSONMenu: Codable {
    let menu: [MenuItem]
    
    enum CodingKeys: String, CodingKey {
            case menu = "menu"
        }
}


struct MenuItem: Codable, Hashable, Identifiable {
    var id = UUID()
    
    let title: String
    let price: String
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case price = "price"
    }

}

let jsonString = """
    {
        "menu": [{
                "title": "Spinach Artichoke Dip",
                "price": "10"
            },
            {
                "title": "Hummus",
                "price": "10"
            },
            {
                "title": "Fried Calamari Rings",
                "price": "51"
            },
            {
                "title": "Fried Mushroom",
                "price": "12"
            },
            {
                "title": "Greek",
                "price": "7"
            },
            {
                "title": "Caesar",
                "price": "7"
            },
            {
                "title": "Mediterranean Tuna Salad",
                "price": "10"
            },
            {
                "title": "Grilled Chicken Salad",
                "price": "12"
            },
            {
                "title": "Water",
                "price": "3"
            },
            {
                "title": "Coke",
                "price": "3"
            },
            {
                "title": "Beer",
                "price": "7"
            },
            {
                "title": "Iced Tea",
                "price": "3"
            }
        ]
    }
"""
    

    func decodeMenu(from jsonString: String) -> JSONMenu? {
        
        do {
            let jsonData = Data(jsonString.utf8)
            let decodedMenu = try JSONDecoder().decode(JSONMenu.self, from: jsonData)
            
            return decodedMenu
        } catch {
            print("Error decoding JSON: \(error)")
            return nil
        }
        
    }












