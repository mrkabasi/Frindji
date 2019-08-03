//
//  Player.swift
//  Friendji
//
//  Created by Kasra Abasi on 8/2/19.
//  Copyright © 2019 kasraabasi. All rights reserved.
//

import Foundation

struct Player: Decodable {
    let gender: Gender
    let name: String
    let age: AgeGroup
    let favoriteColor: String
    let favoriteFruit: String
    let phoneNumber: String
    let pictureImageURL: String
}



enum Gender: Int, Decodable {
    case male
    case female
}



enum AgeGroup: Int, Decodable {
    case a
    case b
    case c
    case d
}
