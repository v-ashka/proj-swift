//
//  PointGeneratorModel.swift
//  idleclicker
//
//  Created by vashka on 03/01/2024.
//

import Foundation

struct PointGeneratorModel: Identifiable {
    var id = UUID()
    var name:String
    var pointsPerSecond: Int
    var level: Int
    var price: Int
    var skin: String
    
}
