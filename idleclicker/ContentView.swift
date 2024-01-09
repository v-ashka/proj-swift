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
    
    var body: some View {
        NavigationView{
            ZStack{
                Image("gym") // "backgroundImage" to nazwa pliku JPG w folderze Assets
                                .resizable()
                                .scaledToFill()
                                .edgesIgnoringSafeArea(.all)
                    .blur(radius: 1.5)
                                .opacity(0.7) // Dodajemy przezroczystość, aby tekst był czytelny na tle

                VStack(alignment: .center, spacing: 15){
                    Text("Points: \(gameState.points)").font(.largeTitle)
                        .shadow(color: .white, radius: 5)

                    
                    if self.gameState.pointsPerSecond > 0 {
                        Text("Points per second: \(gameState.pointsPerSecond)").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .shadow(color: .white, radius: 5)

                    }
                    HStack{
                        NavigationLink(destination: upgradeList){
                            Text("Shop List").font(.title)
                                .shadow(color: .white, radius: 5)

                        }
                    
                        NavigationLink(destination: settingsView){
                            Text("Settings").font(.title)
                        }
                    }
                    Spacer()
                    Button(action:{
                        withAnimation(Animation.easeOut(duration: 0.2)){
                            self.gameState.click()
                            isBicepsExpanded.toggle()
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            withAnimation(Animation.easeInOut(duration: 0.5)) {
                                  isBicepsExpanded.toggle()
                              }
                          }
                    }){
                        Text("\(self.gameState.gameSkin)")
                        .font(.system(size: isBicepsExpanded ? 150 * 1.2 : 150))
                    }
                    .frame(width: 250, height: 250, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    //                .padding(10)
    //                .cornerRadius(5)
    //                .foregroundColor(.white)
                    
                  
                }
            }
      
            
           
        }
    }
    
    
    var upgradeList: some View {
        VStack{
            HStack{
                Text("Points: \(gameState.points)").font(.headline)
                
                if self.gameState.pointsPerSecond > 0 {
                    Text("Points per second: \(gameState.pointsPerSecond)")
                }
            }
            
            List(gameState.pointGenerators){
                pointGenerator in HStack{
                    VStack(alignment: .leading){
                        Text(pointGenerator.name).font(.headline)
                        HStack{
                            Text("Level: ")
                            LazyHStack{
                                if pointGenerator.level > 0 {
                                    ForEach (1...pointGenerator.level, id:\.self){
                                        level in Circle()
                                            .strokeBorder(Color.blue, lineWidth: 5)
                                            .frame(width: 20, height: 20)
                                    }
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
                        .disabled(self.gameState.points < pointGenerator.price)
                    }
                }
            }
        }
    }
    
    let columns = [
        GridItem(.adaptive(minimum: 120))
    ]
    var settingsView: some View{
        
    
            ScrollView{
                Text("Game statistics").font(.largeTitle)
    //            Text("Level: \(self.gameState.pointGenerators.first?.level ?? 0)")
                Text("Points: \(self.gameState.points)")
                Text("Score: \(self.gameState.score)")
                Button(action: {
                    gameState.resetGame()
                }){
                    Text("Restart game")
                }.padding(10)
                .background(Color.red)
                .cornerRadius(5)
                .foregroundColor(.white)
                Spacer(minLength: 50)
                LazyVGrid(columns: columns, spacing: 25){
                    ForEach(gameState.pointGenerators ){
                        item in
                        VStack(alignment: .center, spacing: 15){
                            Text("\(item.name)")
                            Text("Level: \(item.level)")
                        }.padding(10)
                        .onTapGesture {
                            if item.level % 2 == 0 {
                                self.gameState.score += 1
                            }
                        }
                    }.background(Color.gray.opacity(0.1))
                    .cornerRadius(15)
                   
                    
                }
            }.padding(10)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
