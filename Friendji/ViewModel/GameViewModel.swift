//
//  GameViewModel.swift
//  Friendji
//
//  Created by Kasra Abasi on 8/4/19.
//  Copyright © 2019 kasraabasi. All rights reserved.
//

import Foundation

struct GameViewModel: Decodable {
    var gameModel: GameModel
    var heartsString: String {
        switch gameModel.hearts{
        case .one:
            return "❤️💛💛"
        case .two:
            return "❤️❤️💛"
        case .three:
            return "❤️❤️❤️"
        }
    }
    var playerNameString: String {
        return gameModel.player.name
    }
    var playerAgeString: String {
        switch gameModel.player.age {
        case .a:
            return "18 - 22"
        case .b:
            return "23 - 25"
        case .c:
            return "26 - 30"
        case .d:
            return "31 - 40"
        }
    }
    var playerFavoritsString: String {
        return "\(gameModel.player.favoriteColor) color and \(gameModel.player.favoriteFruit) fruit"
    }
    var playerPictureURL: URL? {
        return URL(string: gameModel.player.pictureImageURL)
    }
    var playerPhoneNumberString: String {
        return gameModel.player.phoneNumber
    }
    var gameResult: GameResult {
        return gameModel.gameResult
    }
    var isMatch: Bool? {
        return gameModel.isMatch
    }
}
