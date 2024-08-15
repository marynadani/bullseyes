//
//  ContentView.swift
//  bullseyes
//
//  Created by Maryna Danilova on 19.07.2024.
//

import SwiftUI

struct ContentView: View {
    @State var target: Int = Int.random(in: 1...100)
    @State var number = Double.random(in: 1...100)
    @State var isChosen : Bool = false
    @State var startOver : Bool = false
    @State var score: Int = 0
    @State var round: Int = 0
    
    var body: some View {
        NavigationView {
            VStack {
                    Spacer()
                        .navigationTitle("🎯 Bullseye")
                HStack {
                    Text("Put the bullseye as close as you can to: ")
                    Text(String(target))
                }
                .font(Font.custom("Arial Rounded MT Bold", size: 18))
                .foregroundColor(Color.gray)
                .shadow(color: .black, radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 2, y: 2)
                
                Spacer()
                HStack{
                    
                    Text("0")
                    Slider(value: $number, in: 0...100, step: 1)
                        .animation(.easeOut, value: number)
                    Text("100")
                }
                .font(Font.custom("Arial Rounded MT Bold", size: 23))
                .foregroundColor(Color.orange)
                .shadow(color: .black, radius: 120, x: 1, y: 1)
                
                Button(action: {
                    self.isChosen = true
                }) {
                    Text("Hit me!")
                        .modifier(ValueStyle())
                }
                .alert(isPresented: self.$isChosen) {
                    Alert(title: Text(alertTitle()), message: Text(scoringMessage()), dismissButton: .default(Text("Awesome!")) {
                        startNewRound()  })
                }
                Spacer()
                HStack{
                    
                    Button(action: { self.startOver = true
                    }) {
                        HStack {
                            Image(systemName: "arrow.counterclockwise").scaledToFit()
                            Text("Start over")
                                .modifier(ValueStyle())
                        }
                    }
                    .alert(isPresented: self.$startOver) {
                        Alert(title: Text("New round"), message: Text("Let's start again from the very beginning"), dismissButton: .default(Text("Start again")){
                            startNewGame()
                        })
                    }
                    Spacer()
                    Text("Score: \(score)")
                        .modifier(LabelStyle())
                    
                    Spacer()
                    Text("Round: \(round)")
                        .modifier(LabelStyle())
                    
                    Spacer()
                    NavigationLink( destination: AboutView()) {
                        HStack{
                            Image(systemName: "info.circle")
                            Text("Info")
                                .modifier(ValueStyle())
                        }
                    }
                    
                }
                .padding()
            }
            .onAppear() {
                self.startNewGame()
            }
            .background(Image("background"))
        }
        .navigationViewStyle(.stack)
    
    }
       
    
    // MARK: -- Methods
    
    func pointsForScore() -> Int {
        let maxScore = 100
        let result = abs(Int(number) - target)
        
        let points: Int
        if result == 0 {
            points = 200
        } else if result <= 3 {
            points = 150
        } else {
            points = maxScore - result
        }
        return points
    }
    func scoringMessage() -> String {
        return "The target value is \(target) \n You have chosen \(Int(number)) this time! Congratulation! \n You scored \(self.pointsForScore()) this round"
    }
    func alertTitle() -> String {
        let result = abs(Int(number) - target)
        let title: String
        
        if result == 0 {
            title = "Perfect!"
        } else if result <= 10 {
            title = "You almost had it!"
        } else {
            title = "Not bad"
        }
        return title
    }
    
    func startNewGame() {
        score = 0
        round = 0
        number = 0
        target = Int.random(in: 1...100)
    }
    func startNewRound() {
        score += pointsForScore()
        number = Double.random(in: 1...100)
        target = Int.random(in: 1...100)
        round += 1
    }
   
}

struct LabelStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Arial Rounded MT Bold", size: 18))
            .foregroundColor(Color.black)
            .shadow(color: .white, radius: 7, x: 3, y: 3)
    }
}

struct ValueStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
        .font(Font.custom("Arial Rounded MT Bold", size: 24))
        .foregroundColor(Color.accentColor)
        .modifier(Shadow())
    }
}

struct Shadow : ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: 5, x: 2, y: 2)
    }
}

#Preview {
    ContentView()
}

