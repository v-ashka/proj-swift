//
//  GameStateViewModel.swift
//  idleclicker
//
//  Created by vashka on 03/01/2024.
//

import Foundation
import SwiftUI

class GameStateViewModel: ObservableObject {
    @Published var gameState: GameStateModel
    var timer: Timer?

    init() {
        gameState = GameStateModel(
            points: 50000,
            score: 0,
            pointsPerSecond: 0,
            gameSkin: "💪",
            gymTheme: "gym",
            gameLevel: 0,
            pointGenerators: [
                PointGeneratorModel(name: "Zdrowy posiłek  🥗", pointsPerSecond: 1, level: 0, price: 50, requiredLevel: 0),
                PointGeneratorModel(name: "Suplementacja magnezem 🍚", pointsPerSecond: 2, level: 0, price: 100, requiredLevel: 0),
                PointGeneratorModel(name: "Siła przez energię 🥤", pointsPerSecond: 5, level: 0, price: 250, requiredLevel: 0),
                PointGeneratorModel(name: "Suplementacja kreatyną 💪", pointsPerSecond: 10, level: 0, price: 500, requiredLevel: 1),
                PointGeneratorModel(name: "MOCARZ 💉", pointsPerSecond: 30, level: 0, price: 1000, requiredLevel: 2),
            ],
            gameLevelModel: [
                GameLevelModel(gymTheme: "gym1", gameLevel: 1, earnedPoints: 1000, skin: "💪🏿"),
                GameLevelModel(gymTheme: "gym2", gameLevel: 2, earnedPoints: 2500, skin: "💪🏼"),
                GameLevelModel(gymTheme: "gym3", gameLevel: 3, earnedPoints: 3500, skin: "🦾" ),
            ]
        )

        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.tick()
        }
    }

    func tick() {
        gameState.points += gameState.pointsPerSecond
    }

    func click() {
        gameState.points += 1
    }

    func purchase(pointGenerator: PointGeneratorModel) {
        if pointGenerator.price <= gameState.points {
            gameState.points -= pointGenerator.price
            gameState.pointsPerSecond += pointGenerator.pointsPerSecond

            if let index = gameState.pointGenerators.firstIndex(where: { $0.id == pointGenerator.id }) {
                gameState.pointGenerators[index].level += 1
            }
        }
    }

    func purchaseGameLevel(gameLevel: GameLevelModel) {
        if gameLevel.earnedPoints <= gameState.points {
            gameState.points -= gameLevel.earnedPoints
            gameState.gameSkin = gameLevel.skin
            gameState.gameLevel = gameLevel.gameLevel
            gameState.gymTheme = gameLevel.gymTheme
        }
    }

    func resetGame() {
        gameState.reset()
    }
}
