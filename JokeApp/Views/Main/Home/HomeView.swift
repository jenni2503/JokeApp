
import SwiftUI

struct HomeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var currentJoke: Joke?
    @State var isLoadingJoke = false
    
    var body: some View {
        VStack(spacing:0){
            Text("DagensLatter")
                .font(.system(size: 34, design: .monospaced))
                .fontWeight(.medium)
                .padding(.top, 30)
                .padding(.bottom, 20)
            ZStack{
                
                Color(.white)
                    .ignoresSafeArea()
                
                VStack{
                    Text(currentJoke?.setup ?? "Joke setup should be here")
                        .offset(x: 0, y: -20)
                    Text(currentJoke?.delivery ?? "Joke delivery should be here")
                        .padding(.bottom, 50)
                       
                    
                    HStack {
                        //New joke button
                        //gets disabled when isLoadingJoke is true
                        Button(action: {
                            Task {
                                await RunFetchJoke()
                            }
                        }, label: {
                            Text("New Joke")
                        }).disabled(isLoadingJoke)
                            .padding(.horizontal, 20)
                        
                        //Save button
                        Button(action: {
                            //Maps the fetched joke to a joke entity on the database/core data
                            JokeMapping()
                            //saves the mapping of above to core data
                            SaveEntity()
                            
                        }, label: {
                            Text("Save")
                        }).padding(.horizontal, 20)
                    }
                    
                }
                .task {
                    await RunFetchJoke()
                }
                
                if isLoadingJoke {
                    LoadingJokeView()
                    
                }
            }
        }
        
    }
    
    //This function maps all of the current fetched joke's properties
    //to a core data version of a joke entity/object
    private func JokeMapping() {
        let newItem = SavedJokeEntity(context: viewContext)
        newItem.id = Int32(currentJoke?.id ?? 0)
        newItem.setup = currentJoke?.setup ?? "no setup"
        newItem.delivery = currentJoke?.delivery ?? "no delivery"
        newItem.comment = "No Comment"
        newItem.rating = 0;
    }
    
    //Saves the entity/object to core data
    private func SaveEntity(){
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    //Runs the FetchJoke function and handles all the errors that FetchJoke may throw
    private func RunFetchJoke() async{
        isLoadingJoke = true
        do {
            currentJoke = try await FetchJoke()
        }
        catch JokeError.invalidURL{
            print("error in url")
        }catch JokeError.invalidData{
            print("error in data")
        }catch JokeError.invalidResponse{
            print("error in response")
        } catch {
            print("Unknown error")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: { isLoadingJoke = false })
    }
    
    //fetches the joke from the api
    //and tries to convert the JSON to the Joke Class (check JokeModels in Models folder)
    private func FetchJoke() async throws -> Joke {
        let endpoint: String = "https://v2.jokeapi.dev/joke/Any"
        
        guard let url = URL(string: endpoint) else {
            throw JokeError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let res = response as? HTTPURLResponse, res.statusCode == 200 else {
            throw JokeError.invalidResponse
        }
        
        do{
            let jokeDecoder = JSONDecoder()
            return try jokeDecoder.decode(Joke.self, from: data)
            
        } catch{
            throw JokeError.invalidData
        }
    }
}

//View to show indicator when joke is loading
//RunFetchJoke function sets the isLoadingJoke boolean to true and false
struct LoadingJokeView: View {
    var body: some View {
        Color(.lightGray)
            .ignoresSafeArea()
        VStack{
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .scaleEffect(2.0)
                .padding(.bottom,30)
            Text("A new joke is being retrieved!")
                .padding(.top, 10)
        }
    }
}


#Preview {
    HomeView()
}