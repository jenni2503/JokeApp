import SwiftUI
import CoreData

struct ContentView: View {
    //To make viewContext globally available to all children
    //viewContext is what holds core data's data
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        TabBarView()
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}


