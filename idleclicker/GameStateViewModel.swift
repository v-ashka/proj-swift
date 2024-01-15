//
//  GameStateModel.swift
//  idleclicker
//
//  Created by vashka on 03/01/2024.
//

import Foundation

class GameState: ObservableObject{
    @Published var points = 500
    @Published var score = 0
    @Published var pointsPerSecond = 0
    @Published var gameSkin = "💪"
    @Published var gymTheme = "gym"
    @Published var gameLevel = 0
    
    
    @Published var pointGenerators:[PointGeneratorModel] = [
        PointGeneratorModel(name: "Zdrowy posiłek  🥗", pointsPerSecond: 1, level: 0, price: 50, requiredLevel: 0),
        PointGeneratorModel(name: "Suplementacja magnezem 🍚", pointsPerSecond: 2, level: 0, price: 100, requiredLevel: 0),
        PointGeneratorModel(name: "Siła przez energię 🥤", pointsPerSecond: 5, level: 0, price: 250, requiredLevel: 0),
        PointGeneratorModel(name: "Suplementacja kreatyną 💪", pointsPerSecond: 10, level: 0, price: 500, requiredLevel: 1),
        PointGeneratorModel(name: "MOCARZ 💉", pointsPerSecond: 30, level: 0, price: 1000, requiredLevel: 2),
    ]
    
    @Published var gameLevelModel:[GameLevelModel] = [
        GameLevelModel(gymTheme: "gym1", gameLevel: 1, earnedPoints: 1000, skin: "💪🏿"),
        GameLevelModel(gymTheme: "gym2", gameLevel: 2, earnedPoints: 2500, skin: "💪🏼"),
        GameLevelModel(gymTheme: "gym3", gameLevel: 3, earnedPoints: 3500, skin: "🦾" ),
    ]
    
    var timer:Timer?
    
    init() {
        self.points = 50000
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: {_ in self.tick() })
    }
    
    func click(){
        self.points += 1
    }
    
    func purchase(pointGenerator: PointGeneratorModel){
        if pointGenerator.price <= self.points {
            self.points -= pointGenerator.price
            self.pointsPerSecond += pointGenerator.pointsPerSecond
            
            var newPointGenerators =  self.pointGenerators
            let index = newPointGenerators.firstIndex(where: {$0.id == pointGenerator.id })!
            
//            self.gameSkin = newPointGenerators[index].skin
            newPointGenerators[index].level += 1
            self.pointGenerators = newPointGenerators
            
        }
    }
    
    func purchaseGameLevel(gameLevel: GameLevelModel){
        if gameLevel.earnedPoints <= self.points{
            self.points -= gameLevel.earnedPoints
            
            let newGameLevel = self.gameLevelModel
            let index = newGameLevel.firstIndex(where: {$0.id == gameLevel.id})!
            
            self.gameSkin = newGameLevel[index].skin
            self.gameLevel = newGameLevel[index].gameLevel
            self.gymTheme = newGameLevel[index].gymTheme
        }
    }
    
    
    func tick() {
        self.points += self.pointsPerSecond
    }
    
    func resetGame() {
        self.points = 0
        self.pointsPerSecond = 0
        self.score = 0
        self.gameSkin = "💪"
        self.gameLevel = 0
        self.gymTheme="gym"
        
        self.pointGenerators = [
            PointGeneratorModel(name: "Zdrowy posiłek  🥗", pointsPerSecond: 1, level: 0, price: 50, requiredLevel: 0),
            PointGeneratorModel(name: "Suplementacja magnezem 🍚", pointsPerSecond: 2, level: 0, price: 100, requiredLevel: 0),
            PointGeneratorModel(name: "Siła przez energię 🥤", pointsPerSecond: 5, level: 0, price: 250, requiredLevel: 0),
            PointGeneratorModel(name: "Suplementacja kreatyną 💪", pointsPerSecond: 10, level: 0, price: 500, requiredLevel: 1),
            PointGeneratorModel(name: "MOCARZ 💉", pointsPerSecond: 30, level: 0, price: 1000, requiredLevel: 2),
        ]
    }
}
