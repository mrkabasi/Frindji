//
//  Game.swift
//  Friendji
//
//  Created by Kasra Abasi on 8/3/19.
//  Copyright © 2019 kasraabasi. All rights reserved.
//

import Foundation

struct GameModel: Decodable {
    var hearts: Hearts
    var gameResult: GameResult
    var player: Player
    var isMatch: Bool?
}



enum Hearts: Int, Decodable {
    case one = 1
    case two = 2
    case three = 3
}



enum GameResult: Int, Decodable {
    case nameSharing
    case ageSharing
    case favoritesSharing
    case pictureSharing
    case phoneNumberSharing
    case gameOver
}
