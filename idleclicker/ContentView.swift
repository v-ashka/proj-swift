//
//  ContentView.swift
//  idleclicker
//
//  Created by vashka on 03/01/2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: GameStateViewModel
    @State private var isBicepsExpanded = false
    @State private var isAnimating = false
//    @State private var lastScoreChange = 0
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
                Image("\(viewModel.gameState.gymTheme)")
                                .resizable()
                                .scaledToFill()
                                .edgesIgnoringSafeArea(.all)
                    .blur(radius: 1.5)
                                .opacity(0.7)
                VStack(alignment: .center, spacing: 0){
                    headerDisplay(elems: viewModel)
                    Spacer()
                    Spacer()
                    Spacer()
                    buttonIcon(viewModel: viewModel)
                }
                
            }
            
        }
        
    }
    
    
    
    func headerDisplay(elems: GameStateViewModel) -> some View{
        VStack{
            HStack{
                NavigationLink(destination: UpgradeListView(viewModel: elems)){
                    Text("Shop").font(.title)
                        .shadow(color: .white, radius: 5)
                    Divider()
                }
                NavigationLink(destination: ResetSettingsView(viewModel: elems)){
                    Text("Settings").font(.title)
                        .shadow(color: .white, radius: 5)

                }
            }
            
            Text("Level: \(elems.gameState.gameLevel)")
                .font(.largeTitle)
                    .shadow(color: .white, radius: 5)
            Spacer()
            VStack{
                Text("Points: \(elems.gameState.points) ").font(.largeTitle)
                    .shadow(color: .white, radius: 5)

                
                if elems.gameState.pointsPerSecond > 0 {
                    Text("Points per second: \(elems.gameState.pointsPerSecond)").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .shadow(color: .white, radius: 5)
                        .scaleEffect(isAnimating ? 1.3 : 1)
                        .animation(elems.gameState.pointsPerSecond > 0 ? foreverAnimation : .default).onAppear{
                            self.isAnimating = true
                        }

                }
            }        }
            .frame(width: .infinity, height: 100)
    }
    
    func buttonIcon(viewModel: GameStateViewModel) -> some View{
        VStack{
            Button(action:{
            
                withAnimation(Animation.easeOut(duration: 0.1)){
                    viewModel.click()
                    isBicepsExpanded.toggle()
                }
//
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    withAnimation(Animation.easeInOut(duration: 0.2)) {
                          isBicepsExpanded.toggle()
                      }
                  }
            }){
                Text("\(viewModel.gameState.gameSkin)")
                    .shadow(color: .white, radius: 5)
                .font(.system(size: isBicepsExpanded ? 150 * 1.5 : 190))
                    .animation(viewModel.gameState.pointsPerSecond > 0 ? tickAnimation : .default)
                                          
            }//                    .scaleEffect(animateBicep ? 1.2 : 1)

        }
    }
    
    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: GameStateViewModel.init())
    }
}
}
