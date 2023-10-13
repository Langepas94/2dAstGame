//
//  ScoreModel.swift
//  2dAstGame
//
//  Created by Артём Тюрморезов on 11.10.2023.
//

import Foundation

struct ScoreModel: Codable {
    var name: String
    var score: Int
    var userImg: String?
    
    mutating func clear() {
        score = 0
    }
}
