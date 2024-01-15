//
//  GameStateModel.swift
//  idleclicker
//
//  Created by vashka on 03/01/2024.
//

import Foundation

struct PointGeneratorModel: Identifiable {
    var id = UUID()
    var name: String
    var pointsPerSecond: Int
    var level: Int
    var price: Int
    var requiredLevel: Int
}

struct GameLevelModel: Identifiable {
    var id = UUID()
    var gymTheme: String
    var gameLevel: Int
    var earnedPoints: Int
    var skin: String
}

struct GameStateModel {
    var points: Int
    var score: Int
    var pointsPerSecond: Int
    var gameSkin: String
    var gymTheme: String
    var gameLevel: Int
    var pointGenerators: [PointGeneratorModel]
    var gameLevelModel: [GameLevelModel]
}

extension GameStateModel {
    mutating func reset() {
        points = 0
        score = 0
        pointsPerSecond = 0
        gameSkin = "💪"
        gameLevel = 0
        gymTheme = "gym"

        pointGenerators = [
            PointGeneratorModel(name: "Zdrowy posiłek  🥗", pointsPerSecond: 1, level: 0, price: 50, requiredLevel: 0),
            PointGeneratorModel(name: "Suplementacja magnezem 🍚", pointsPerSecond: 2, level: 0, price: 100, requiredLevel: 0),
            PointGeneratorModel(name: "Siła przez energię 🥤", pointsPerSecond: 5, level: 0, price: 250, requiredLevel: 0),
            PointGeneratorModel(name: "Suplementacja kreatyną 💪", pointsPerSecond: 10, level: 0, price: 500, requiredLevel: 1),
            PointGeneratorModel(name: "MOCARZ 💉", pointsPerSecond: 30, level: 0, price: 1000, requiredLevel: 2),
        ]
    }
}
