import SwiftUI

struct SavedJokeDetailsView: View {
    var selectedJoke: SavedJokeEntity
    var body: some View {
        VStack{
            Text("\(selectedJoke.id)")
            Text(selectedJoke.setup ?? "No setup")
            Text(selectedJoke.delivery ?? "No delivery")
            Text("\(selectedJoke.rating)")
            Text(selectedJoke.comment ?? "No comment")
            
        }
        
    }
}

//#Preview {
//    SavedJokeDetailsView()
//}
