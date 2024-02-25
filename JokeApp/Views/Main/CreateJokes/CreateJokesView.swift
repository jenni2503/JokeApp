//
//  CreateJokesView.swift
//  JokeApp
//
//  Created by Jennifer Luu on 25/02/2024.
//

import SwiftUI

struct CreateJokesView: View {
    @State private var jokeText = ""
    @State private var selectedCategory = ""
    
    var body: some View {
        Form {
                Section {
                    TextField("Create the joke", text: $jokeText)
                }
                
                Section {
                    Picker("Choose Category", selection: $selectedCategory) {
                        Text("Dark").tag("Dark")
                        Text("Programming").tag("Programming")
                        Text("Pun").tag("Pun")
                        Text("Msic").tag("Misc")
                        Text("Christmas").tag("Christmas")
                        Text("Spooky").tag("Spooky")
                    }
                }
                
                Section {
                    Button("Add the joke") {
                        if !jokeText.isEmpty && !selectedCategory.isEmpty {

                        } else {
                            // show error
                        }
                    }
                }
            }
        }
}

#Preview {
    CreateJokesView()
}
