//
//  CreateJokesView.swift
//  JokeApp
//
//  Created by Jennifer Luu on 25/02/2024.
//

import SwiftUI

struct CreateJokesView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var jokeSetUp = ""
    @State private var jokeDelivery = ""
    @State private var selectedCategory = "Misc"
    @State private var addSavedAlert = false
    @State private var errorAlert = false
    @State private var errorOrSaved = false
    
    var body: some View {
        Form {
                Section {
                    TextField("Create the joke set up", text: $jokeSetUp)
                }

                Section{
                    TextField("Create the joke delivery", text: $jokeDelivery)
                }
                
                Section {
                    Picker("Choose Category", selection: $selectedCategory) {
                        Text("Misc").tag("Misc")
                        Text("Dark").tag("Dark")
                        Text("Programming").tag("Programming")
                        Text("Pun").tag("Pun")
                        Text("Christmas").tag("Christmas")
                        Text("Spooky").tag("Spooky")
                    }
                }
                
                Section {
                    Button("Add the joke") {
                        if(jokeSetUp == "") || (jokeDelivery == ""){
                            errorAlert = true
                            errorOrSaved = true
                        } else {
                            let newJoke = SavedJokeEntity(context: viewContext)
                            newJoke.category = selectedCategory
                            newJoke.setup = jokeSetUp
                            newJoke.delivery = jokeDelivery
                            newJoke.comment = ""
                            newJoke.rating = 0;
                            SaveEntity()
                            addSavedAlert = true
                            errorOrSaved = true
                        }
                    }
                    .alert(isPresented: $errorOrSaved) {
                        Alert(title: addSavedAlert ? Text("Joke has been created!")
                            : Text("Please fill out all fields!"), dismissButton: .cancel(Text("Done"), action: {
                                addSavedAlert = false
                               errorOrSaved = false
                               errorAlert = false
                            selectedCategory = "Misc"
                            jokeSetUp = ""
                            jokeDelivery = ""
                            } ))
                        }
                }
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
    CreateJokesView()
}

