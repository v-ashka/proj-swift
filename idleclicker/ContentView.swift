//
//  ContentView.swift
//  idleclicker
//
//  Created by vashka on 03/01/2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var gameState = GameState()
    @State private var isBicepsExpanded = false
    @State private var isAnimating = false
    @State private var lastScoreChange = 0
    @State private var animateBicep = false
    var foreverAnimation: Animation {
          Animation.linear(duration: 0.3)
          .repeatForever()
      }
    
    var tickAnimation: Animation {
        Animation.easeIn(duration: 1).repeatForever()
    }
    
    
    var body: some View {
        NavigationView{
            ZStack{
                Image("\(gameState.gymTheme)")
                                .resizable()
                                .scaledToFill()
                                .edgesIgnoringSafeArea(.all)
                    .blur(radius: 1.5)
                                .opacity(0.7)
                VStack(alignment: .center, spacing: 0){
                    HStack{
                        NavigationLink(destination: upgradeList){
                            Text("Shop").font(.title)
                                .shadow(color: .white, radius: 5)
Divider()
                        }
                        NavigationLink(destination: settingsView){
                            Text("Settings").font(.title)
                                .shadow(color: .white, radius: 5)

                        }
                    }
                    Spacer()
                    Text("Level: \(gameState.gameLevel)")
                        .font(.largeTitle)
                            .shadow(color: .white, radius: 5)
                    Spacer()
                    VStack{
                        Text("Points: \(gameState.points) ").font(.largeTitle)
                            .shadow(color: .white, radius: 5)

                        
                        if self.gameState.pointsPerSecond > 0 {
                            Text("Points per second: \(gameState.pointsPerSecond)").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                .shadow(color: .white, radius: 5)
                                .scaleEffect(isAnimating ? 1.3 : 1)
                                .animation(self.gameState.pointsPerSecond > 0 ? foreverAnimation : .default).onAppear{
                                    self.isAnimating = true
                                }

                        }
                    }
              Spacer()

                    Spacer()
                    Spacer()
                    Button(action:{
                    
                        withAnimation(Animation.easeOut(duration: 0.1)){
                            self.gameState.click()
                            lastScoreChange += 1
                            isBicepsExpanded.toggle()
                        }
//
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            withAnimation(Animation.easeInOut(duration: 0.2)) {
                                  isBicepsExpanded.toggle()
                              }
                          }
                    }){
                        Text("\(self.gameState.gameSkin)")
                            .shadow(color: .white, radius: 5)
                        .font(.system(size: isBicepsExpanded ? 150 * 1.5 : 190))
                            .animation(self.gameState.pointsPerSecond > 0 ? tickAnimation : .default)
                                                  
                    }

                    .scaleEffect(animateBicep ? 1.2 : 1)

                  
                }
                
            }
            
        }
        
    }
    
    let columns = [
        GridItem(.adaptive(minimum: 120), spacing: 0)
    ]

    
    var upgradeList: some View {
            VStack{
                Text("Your level: \(gameState.gameLevel)").font(.headline)
                HStack{
                    Text("Points: \(gameState.points)").font(.headline)
                    
                    if self.gameState.pointsPerSecond > 0 {
                        Text("Points per second: \(gameState.pointsPerSecond)")
                    }
                }
               
                LazyVGrid(columns: columns, spacing: 15){
                    ForEach(gameState.gameLevelModel){
                        item in
                        HStack{
                
                            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/){
                                Text("Level: \(item.gameLevel)")
                                Spacer()
                                Text("Skin: \(item.skin)")
                                Spacer()
                                Text("Require points: \(item.earnedPoints)")
                                Button(action: {
                                    self.gameState.purchaseGameLevel(gameLevel: item)
                                }){
                                    Text("Purchase")
                                }.disabled(gameState.points < item.earnedPoints) 
                            }
                        }.padding(10)
                        .background(gameState.points >= item.earnedPoints  ? Color.blue.opacity(0.1) :  Color.gray.opacity(0.1))
                        .cornerRadius(15)
                        
                    }
                }
                Divider()
                List(gameState.pointGenerators){
                    pointGenerator in HStack{
                        VStack(alignment: .leading){
                            Text(pointGenerator.name).font(.headline)
                            HStack{
                                Text("Level: ")
                                LazyHStack{
                                    if pointGenerator.level > 0 {
                                        Text("\(pointGenerator.level)")
                                    }else{
                                        Text("0")
                                    }
                                }
                              
                            }
                            Text("Points per Second: \(pointGenerator.pointsPerSecond)")
                            Text("Price: \(pointGenerator.price)")
                        }
                        Spacer()
                        Group{
                            Button(action: {
                                self.gameState.purchase(pointGenerator: pointGenerator)
                            }){
                                Text("Purchase")
                            }
                            .buttonStyle(BorderlessButtonStyle())
                            .disabled(self.gameState.points < pointGenerator.price || gameState.gameLevel < pointGenerator.requiredLevel)
                        }
                    }
                }
            }
        
    
    }
    

    var settingsView: some View{
        
    
            ScrollView{
                Text("Game statistics").font(.largeTitle)
                Text("Points: \(self.gameState.points)")
                Text("Your game level: \(self.gameState.gameLevel)")
                Button(action: {
                    gameState.resetGame()
                }){
                    Text("Restart game")
                }.padding(10)
                .background(Color.red)
                .cornerRadius(5)
                .foregroundColor(.white)
                Spacer(minLength: 50)
                LazyVGrid(columns: columns, spacing: 5 ){
                    ForEach(gameState.pointGenerators ){
                        item in
                        VStack(alignment: .leading){
                            Text("\(item.name)")
                            Text("Level: \(item.level)")
                        }.padding()
                      
                        
                    }.background(Color.gray.opacity(0.1))
                    .cornerRadius(15)
                    
                }
                .aspectRatio(16/9, contentMode: .fit)
            }.padding(10)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
