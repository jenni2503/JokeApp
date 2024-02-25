import SwiftUI

struct SavedJokeDetailsView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @State var currentRating: Int16
    var selectedJoke: SavedJokeEntity
    
    var body: some View {
        VStack{
            Text(selectedJoke.category ?? "Unknown Category")
                .padding(.bottom, 200)
                .font(.title2)
                .fontWeight(.light)
            
            Text(selectedJoke.setup ?? "No setup")
                .fontWeight(.bold)
                .padding(.top, -100)
              
            
            Text(selectedJoke.delivery ?? "No delivery")
                .padding(.bottom, 120)
                
            
            Text("\(selectedJoke.rating) stars")
                .padding(.bottom, 30)
                .fontWeight(.semibold)
            
            HStack {
                ForEach(1..<6) {i in
                    Image(systemName: "star.fill")
                        .font(.title3)
                        .foregroundColor(selectedJoke.rating >= i ? Color.yellow : Color.gray)
                        .onTapGesture {
                            selectedJoke.rating = Int16(i)
                            
                            do {
                                try viewContext.save()
                            } catch {
                                // Replace this implementation with code to handle the error appropriately.
                                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                                let nsError = error as NSError
                                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                            }
                        }
                }
            }
            
            
            Text(selectedJoke.comment ?? "No comment")
                .padding(.top, 50)
            
        }
        
    }
}

//#Preview {
//    SavedJokeDetailsView()
//}
