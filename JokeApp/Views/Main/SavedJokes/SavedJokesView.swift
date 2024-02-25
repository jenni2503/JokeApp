
import SwiftUI

struct SavedJokesView: View {
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
    
    enum CategoryOptions: String, CaseIterable {
        case AnyCategory = "Any"
        case MiscCategory = "Misc"
        case ProgrammingCategory = "Programming"
        case DakrCategory = "Dark"
        case PunCategory = "Pun"
        case SpookyCategory = "Spooky"
        case ChristmasCategory = "Christmas"
    }
}

#Preview {
    SavedJokesView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
