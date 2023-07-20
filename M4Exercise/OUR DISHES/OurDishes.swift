import SwiftUI
import CoreData



struct OurDishes: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject var dishesModel = DishesModel()
    @State private var showAlert = false
    @State var searchText = ""
    @State var menu: JSONMenu?
    
    
    func buildPredicate() -> NSPredicate {
        if searchText.isEmpty {
            return NSPredicate(value: true)
        } else {
            
            let predicate = NSPredicate(format: "name CONTAINS[cd] %@", searchText)
            return predicate
        }
    }
    
    func buildSortDescriptors() -> [NSSortDescriptor] {
        
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))
        return [sortDescriptor]
    }
    
    var body: some View {
        VStack {
            LittleLemonLogo()
                .padding(.bottom, 10)
                .padding(.top, 50)
            
            Text ("Tap to order")
                .foregroundColor(.black)
                .padding([.leading, .trailing], 40)
                .padding([.top, .bottom], 8)
                .background(Color("approvedYellow"))
                .cornerRadius(20)
            
            
            
            NavigationView {
                FetchedObjects(
                    predicate:buildPredicate(),
                    sortDescriptors: buildSortDescriptors()) {
                        (dishes: [Dish]) in
                        
                        List {
                            if let menu = menu {
                                ForEach(menu.menu) { item in
                                    Button(action: {
                                        showAlert.toggle()
                                    }) {
                                        HStack {
                                            Text(item.title)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                            
                                            Spacer()
                                            Text("$")
                                            Spacer()
                                            
                                            Text(String(format: "%.2f", Float(item.price) ?? 0.0))
                                                .frame(alignment: .trailing)
                                        }
      
                                    }
                                }
                                
                            } else {
                                Text("Loading...")
                            }
                        }
                            
                            
                            .padding(.top, -10)//
                            
                            .alert("Order placed, thanks!",
                                   isPresented: $showAlert) {
                                Button("OK", role: .cancel) { }
                            }
                            
                           
                                   .scrollContentBackground(.hidden)
                            
                            // uncomment the code below if you want to check through a simulator
//                                   .task {
//                                       await dishesModel.reload(viewContext)
//                                   }
                                   .searchable(text: $searchText)
                        }
                    }
            .onAppear() {
                if let decodedMenu = decodeMenu(from: jsonString) {
                    menu = decodedMenu

                }
            }
        }
    }
}

  
            
            struct OurDishes_Previews: PreviewProvider {
                static var previews: some View {
                    OurDishes()
                }
            }
            
            
            
            
            
            
        
