import Foundation
import SwiftUI
import CoreData

struct TabBarView: View {
    var body: some View {
        VStack {
            
            // TabView
            TabView {
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }

                SavedJokesView()
                    .tabItem {
                        Label("Saved", systemImage: "square.and.arrow.down")
                    }
            }
        }
    }
}
