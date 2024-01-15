//
//  ResetSettingsView.swift
//  idleclicker
//
//  Created by vashka on 15/01/2024.
//

//impo
import SwiftUI

struct ResetSettingsView: View{
    @ObservedObject var viewModel: GameStateViewModel
    let columns = [
        GridItem(.adaptive(minimum: 120), spacing: 0)
    ]
    var body: some View {
        ScrollView(){
                    Text("Game statistics").font(.largeTitle)
                    Text("Points: \(viewModel.gameState.points)")
                    Text("Your game level: \(viewModel.gameState.gameLevel)")
                    Button(action: {
                        viewModel.resetGame()
                    }){
                        Text("Restart game")
                    }.padding(10)
                    .background(Color.red)
                    .cornerRadius(5)
                    .foregroundColor(.white)
                    Spacer(minLength: 50)
                    LazyVGrid(columns: columns, spacing: 15 ){
                        ForEach(viewModel.gameState.pointGenerators ){
                            item in
                            VStack(alignment: .leading){
                                Text("\(item.name)")
                                Text("Level: \(item.level)")
                            }.padding()
                          
                            
                        }.background(Color.gray.opacity(0.1))
                        .cornerRadius(15)
                        
                    }
                    .aspectRatio(contentMode: .fit)
                }.padding(10)
        }
    }
    

