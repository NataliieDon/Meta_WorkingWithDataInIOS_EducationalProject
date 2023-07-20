import Foundation
import CoreData


extension Dish {
    static func dishExists(withTitle title: String, in context: NSManagedObjectContext) -> Bool {
        let fetchRequest: NSFetchRequest<Dish> = Dish.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title == %@", title)
        fetchRequest.fetchLimit = 1

        do {
            let existingDishes = try context.fetch(fetchRequest)
            return !existingDishes.isEmpty
        } catch {
            print("Error fetching dishes: \(error)")
            return false
        }
    }
}

extension Dish {
    static func createDishesFrom(menuItems: [MenuItem], _ context: NSManagedObjectContext) {
        for menuItem in menuItems {
            let title = menuItem.title
            if !Dish.dishExists(withTitle: title, in: context) {
                let newDish = Dish(context: context)
                newDish.title = title

                if let priceFloat = Float(menuItem.price) {
                    newDish.price = priceFloat 
                } else {
                    print("Error converting price to Float")
                }
            }
        }

        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
}



   
