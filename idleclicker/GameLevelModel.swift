//
//  GameLevelModel.swift
//  idleclicker
//
//  Created by vashka on 12/01/2024.
//

import Foundation

struct GameLevelModel: Identifiable {
    var id = UUID()
    var gymTheme:String
    var gameLevel: Int
    var earnedPoints: Int
    var skin: String
}
