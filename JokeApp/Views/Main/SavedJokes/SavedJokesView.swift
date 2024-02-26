
import SwiftUI

struct SavedJokesView: View {
    @Environment(\.managedObjectContext) private var viewContext
    //Get all SavedJokeEntity from database/core data and sort them by their rating in descending order
    //reulting data is stored in jokes variable
    @FetchRequest(entity: SavedJokeEntity.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \SavedJokeEntity.rating, ascending: false)])
    var jokes: FetchedResults<SavedJokeEntity>
    
    @State private var selectedCategory: String = "Any"
    
    var body: some View {
        NavigationView(content: {
            List {
                ForEach(jokes) { joke in
                    if ( joke.category == selectedCategory ) ||
                        ( selectedCategory == "Any" ) {
                        
                        NavigationLink(destination: SavedJokeDetailsView(currentRating: joke.rating, currentComment: joke.comment ?? "No Comment", selectedJoke: joke))
                        {
                            Text(String(joke.setup?.prefix(20) ?? "did not load") + " ...")
                                .foregroundStyle(.black)
                            
                            Text("\(joke.rating)/5")
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            
                        }
                    }
                    
                }
                .onDelete(perform: UnsaveJoke)
            }
            .navigationTitle("Saved Jokes")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Menu("Sort by") {
                        Picker("", selection: $selectedCategory) {
                            ForEach(CategoryOptions.allCases, id: \.rawValue) { category in
                                Text(category.rawValue)
                                    .tag(category.rawValue)
                            }
                        }
                    }
                }
            }
        })
        
    }
    
    private func UnsaveJoke(offsets: IndexSet) {
        withAnimation{
            guard let index = offsets.first else {
                return
            }
            
            let selectedJokeEntity = jokes[index]
            viewContext.delete(selectedJokeEntity)
            
            SaveEntity()
        }
        
    }
    
    //Saves the entity/object to core data
    private func SaveEntity(){
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

#Preview {
    SavedJokesView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
