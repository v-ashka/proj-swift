//
//  GameStateModel.swift
//  idleclicker
//
//  Created by vashka on 03/01/2024.
//

import Foundation

class GameState: ObservableObject{
    @Published var points = 0
    @Published var score = 0
    @Published var pointsPerSecond = 0
    @Published var gameSkin = "💪"
    @Published var pointGenerators:[PointGeneratorModel] = [
        PointGeneratorModel(name: "Point Generator #1", pointsPerSecond: 1, level: 0, price: 50, skin: "💪🏿"),
        PointGeneratorModel(name: "Point Generator #2", pointsPerSecond: 2, level: 0, price: 100, skin: "💪"),
        PointGeneratorModel(name: "Point Generator #3", pointsPerSecond: 5, level: 0, price: 250, skin: "💪"),
        PointGeneratorModel(name: "Point Generator #4", pointsPerSecond: 10, level: 0, price: 500, skin: "💪"),
        PointGeneratorModel(name: "Point Generator #5", pointsPerSecond: 25, level: 0, price: 1000, skin: "💪"),
        PointGeneratorModel(name: "Point Generator #5", pointsPerSecond: 25, level: 0, price: 1000, skin: "💪"),
        PointGeneratorModel(name: "Skin Generator #5", pointsPerSecond: 0, level: 0, price: 1200, skin: "💪🏿"),
        PointGeneratorModel(name: "Skin Generator #5", pointsPerSecond: 0, level: 0, price: 1500, skin: "💪🏼"),
    ]
    
    var timer:Timer?
    
    init() {
        self.points = 1
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
            
            self.gameSkin = newPointGenerators[index].skin
            newPointGenerators[index].level += 1
            self.pointGenerators = newPointGenerators
            
            if newPointGenerators[index].level > 5 {
                self.score += 1
            }
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
        self.pointGenerators = [
            PointGeneratorModel(name: "Point Generator #1", pointsPerSecond: 1, level: 0, price: 50, skin: "💪🏿"),
            PointGeneratorModel(name: "Point Generator #2", pointsPerSecond: 2, level: 0, price: 100, skin: "💪"),
            PointGeneratorModel(name: "Point Generator #3", pointsPerSecond: 5, level: 0, price: 250, skin: "💪"),
            PointGeneratorModel(name: "Point Generator #4", pointsPerSecond: 10, level: 0, price: 500, skin: "💪"),
            PointGeneratorModel(name: "Point Generator #5", pointsPerSecond: 25, level: 0, price: 1000, skin: "💪"),
            PointGeneratorModel(name: "Point Generator #5", pointsPerSecond: 25, level: 0, price: 1000, skin: "💪"),
            PointGeneratorModel(name: "Skin Generator #5", pointsPerSecond: 0, level: 0, price: 1200, skin: "💪🏿"),
            PointGeneratorModel(name: "Skin Generator #5", pointsPerSecond: 0, level: 0, price: 1500, skin: "💪🏼"),
        ]
    }
}
