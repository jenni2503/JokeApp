import SwiftUI

struct SavedJokeDetailsView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @State var currentRating: Int16
    @State var currentComment: String
    var selectedJoke: SavedJokeEntity
    @State private var saveChangesAlert = false
    
    
    var body: some View {
        VStack(spacing: 10){
            Spacer()
            Text(selectedJoke.setup ?? "No setup")
                .fontWeight(.bold)
                .font(.title2)
            
            Text(selectedJoke.delivery ?? "No delivery")
                .fontWeight(.regular)
            
            Spacer()
            
            Text("\(currentRating) stars")
                .padding(.bottom, 30)
                .fontWeight(.semibold)
            
            HStack {
                ForEach(1..<6) {i in
                    Image(systemName: "star.fill")
                        .font(.title3)
                        .foregroundColor(currentRating >= i ? Color.yellow : Color.gray)
                        .onTapGesture {
                            currentRating = Int16(i)
                            
                        }
                }
            }
            Spacer()
            
            TextField("Add Comment", text: $currentComment)
                .padding(.leading, 10)
            Spacer()
            Button(
                action: SaveChanges, label: {
                    Text("Save Changes")
                }
            ).alert(isPresented: $saveChangesAlert) {
                Alert(title: Text("Saved Changes"), dismissButton: .cancel(Text("Done"), action: {} ))
            }
            
            Spacer()
        }.navigationTitle(selectedJoke.category ?? "Unknown Category")
        
    }
    
    private func SaveChanges() {
        print("runs")
        selectedJoke.rating = currentRating
        selectedJoke.comment = currentComment
        do {
            try viewContext.save()
            saveChangesAlert = true
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

//#Preview {
//    SavedJokeDetailsView()
//}
