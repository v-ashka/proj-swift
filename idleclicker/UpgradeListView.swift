//
//  UpgradeListView.swift
//  idleclicker
//
//  Created by vashka on 15/01/2024.
//

import Foundation
import SwiftUI

struct UpgradeListView: View {
    @ObservedObject var viewModel: GameStateViewModel
    let columns = [
        GridItem(.adaptive(minimum: 120), spacing: 0)
    ]
    
    var body: some View{
        VStack{
            Text("Your level: \(viewModel.gameState.gameLevel)").font(.headline)
            HStack{
                Text("Points: \(viewModel.gameState.points)").font(.headline)
                
                if viewModel.gameState.pointsPerSecond > 0 {
                    Text("Points per second: \(viewModel.gameState.pointsPerSecond)")
                }
            }
           
            LazyVGrid(columns: columns, spacing: 15){
                ForEach(viewModel.gameState.gameLevelModel){
                    item in
                    HStack{
            
                        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/){
                            Text("Level: \(item.gameLevel)")
                            Spacer()
                            Text("Skin: \(item.skin)")
                            Spacer()
                            Text("Require points: \(item.earnedPoints)")
                            Button(action: {
                                viewModel.purchaseGameLevel(gameLevel: item)
                            }){
                                Text("Purchase")
                            }.disabled(viewModel.gameState.points < item.earnedPoints)
                        }
                    }.padding(10)
                    .background(viewModel.gameState.points >= item.earnedPoints  ? Color.blue.opacity(0.1) :  Color.gray.opacity(0.1))
                    .cornerRadius(15)
                    
                }
            }
            Divider()
            List(viewModel.gameState.pointGenerators){
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
                            viewModel.purchase(pointGenerator: pointGenerator)
                        }){
                            Text("Purchase")
                        }
                        .buttonStyle(BorderlessButtonStyle())
                        .disabled(viewModel.gameState.points < pointGenerator.price || viewModel.gameState.gameLevel < pointGenerator.requiredLevel)
                    }
                }
            }
        }
    }
}
