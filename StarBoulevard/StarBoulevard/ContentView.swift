//
//  ContentView.swift
//  StarBoulevard
//
//  Created by Marius on 31/08/2023.
//  Optimized for iPhone 15.
//

import SwiftUI

let films =
["Night on Earth": "R. Benigni",
 "Collateral": "T. Cruise",
 "Joker": "J. Phoenix",
 "Downfall": "B. Ganz",
 "Finding Graceland": "H. Keitel",
 "Blood Sport": "J. van Damme",
 "Batman": "C. Bale",
 "Beutiful Mind": "R. Crowe",
 "Bourne Trilogy": "M. Damon",
 "About a Boy": "H. Grant",
 "Doctor Zhivago": "O. Sharif",
 "Titanic": "L. DiCaprio",
 "The Office": "R. Gervais",
 "Onegin": "R. Finnes",
 "Rambo": "S. Stalone",
 "Pulp Fiction": "J. Travolta",
 "Legends of the Fall": "B. Pitt",
 "Matrix": "K. Reeves",
 "Fight Club": "E. Norton.",
 "Usual Suspects": "K. Spacey",
 "Braveheart": "M. Gibson",
 "About Schmidt": "J. Nicholson",
 "Casablanca": "I. Bergman",
 "The Wizard of Oz": "J. Garland",
 "The Third Man": "O. Welles",
 "Ben Hur": "C. Heston",
 "Trainspotting": "E. McGregor",
 "Gone with the Wind": "V. Leigh",
 "Some like it hot": "J. Lemon",
 "Die Hard": "B. Willis"]

struct ContentView: View {
    @State private var correctPick = Int.random(in: 0...2)
    @State private var pickedActor = -1
    @State private var pickFeedback = String()
    @State private var showGameOver = false
    @State private var showPoints = false
    @State private var pointsAquired = 0
    @State private var questionNumber = 1
    @State private var filmsTemp = films.shuffled()
    
    var body: some View {
         ZStack {
             LinearGradient(gradient: Gradient(stops: [
                 Gradient.Stop(color: .cyan, location: 0.88),
                 Gradient.Stop(color: .purple, location: 0.89),
             ]), startPoint: .top, endPoint: .bottom)
             .ignoresSafeArea()
             
             VStack(spacing: 35) {
                 Spacer()
                 
                 VStack {
                     Text("⭐️ Star ⭐️")
                         .font(.system(size: 30, weight: .bold))
                         .italic()
                         .foregroundColor(.pink)
                     Text("Boulevard")
                         .font(.system(size: 38, weight: .bold))
                         .foregroundColor(.yellow)
                 }

                 VStack(spacing: 25) {
                     VStack{
                         Text("Who starred in")
                             .font(.subheadline.weight(.heavy))
                             .foregroundStyle(.secondary)
                         Text(filmsTemp[correctPick].key)
                             .font(.largeTitle.weight(.heavy))
                             .foregroundColor(.green)
                     }
                     ForEach(0..<3) { number in
                         Button {
                             actorChosed(number)
                         } label: {
                             Text(filmsTemp[number].value)
                                 .padding()
                                 .frame(maxWidth: 200)
                                 .font(.system(size: 25, weight: .bold))
                                 .foregroundColor(Color(red: 1, green: 1, blue: 1))
                                 .background(Color(red: 1, green: 0.2, blue: 0.7))
                                 .clipShape(RoundedRectangle(cornerRadius: 15))
                         }
                         .rotation3DEffect(.degrees(pickedActor == number ? 360: 0), axis: (x: 1, y: 0, z: 0))
                         .opacity(pickedActor == -1 || pickedActor == number ? 1.0 : 0.25)
                         .scaleEffect(pickedActor == -1 || pickedActor == number ? 1 : 0.7)
                         .animation(.default, value: pickedActor)
                     }
                 }
                 .frame(maxWidth: .infinity)
                 .padding(.vertical, 35)
                 .background(.bar)
                 .clipShape(RoundedRectangle(cornerRadius: 20))
                 
                 Text("Question \(questionNumber) of 7")
                     .font(.system(size: 20, weight: .bold))
                     .foregroundColor(.white)
                 
                 Spacer()
                 Spacer()
                 
                 Text("Points: \(pointsAquired)")
                     .font(.system(size: 33, weight: .bold))
                     .foregroundColor(.yellow)
             }
             .padding()
         }
         .alert(pickFeedback, isPresented: $showPoints) {
             Button("Continue", action: nextQuestion)
         } message: {
             
         }
         .alert("Game Over", isPresented: $showGameOver) {
             Button("New Game", action: restartGame)
         } message: {
             Text(finalResult())
         }
     }
     
     func actorChosed(_ number: Int) {
         if number == correctPick {
             pickFeedback = "Correct!"
             pointsAquired += 1
             showPoints = true
         } else {
             pickFeedback = "Wrong! It's \(filmsTemp[correctPick].value)"
             pointsAquired += 0
             showPoints = true
         }
         
         if  questionNumber == 7 {
             showPoints = false
             showGameOver = true
         }
         
         pickedActor = number
     }
     
     func nextQuestion() {
         filmsTemp.remove(at: correctPick)
         correctPick = Int.random(in: 0...2)
         questionNumber += 1
         pickedActor = -1
     }
     
     func restartGame() {
         filmsTemp = films.shuffled()
         correctPick = Int.random(in: 0...2)
         pointsAquired = 0
         questionNumber = 1
         pickedActor = -1
     }
    
    func finalResult() -> String {
        var message = ""
        if pointsAquired <= 2 {
            message = """
                      Last answer: \(pickFeedback)
                      \(pointsAquired) out of 7. Don't like films ?
                      """
        } else if pointsAquired <= 3 {
            message = """
                      Last answer: \(pickFeedback)
                      \(pointsAquired) out of 7. You can do better!
                      """
        } else if pointsAquired <= 4 {
            message = """
                      Last answer: \(pickFeedback)
                      \(pointsAquired) out of 7. Not bad!
                      """
        } else if pointsAquired <= 5 {
            message = """
                      Last answer: \(pickFeedback)
                      \(pointsAquired) out of 7. Good!
                      """
        } else if pointsAquired <= 6 {
            message = """
                      Last answer: \(pickFeedback)
                      \(pointsAquired) out of 7. Well done!
                      """
        } else {
            message = """
                      Last answer: \(pickFeedback)
                      \(pointsAquired) out of 7. Wow! Cinephile here!
                      """
        }
        return message
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
