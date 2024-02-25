
import SwiftUI

struct SavedJokesView: View {
    //Get all SavedJokeEntity from database/core data and sort them by their rating in descending order
    //reulting data is stored in jokes variable
    @FetchRequest(entity: SavedJokeEntity.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \SavedJokeEntity.rating, ascending: false)])
    var jokes: FetchedResults<SavedJokeEntity>
    
    
    var body: some View {
            NavigationView(content: {
                List {
                    ForEach(jokes) { joke in
                        NavigationLink(destination: SavedJokeDetailsView(selectedJoke: joke)) {
                            Text(String(joke.setup?.prefix(20) ?? "did not load") + " ...")
                                .foregroundStyle(.black)
                        }
                    }
                }
            })
        
    }
}

#Preview {
    SavedJokesView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
