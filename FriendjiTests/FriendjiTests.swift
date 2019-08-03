//
//  FriendjiTests.swift
//  FriendjiTests
//
//  Created by Kasra Abasi on 8/2/19.
//  Copyright © 2019 kasraabasi. All rights reserved.
//

/// for savaing time i am wring test just for GameViewModelTests

import XCTest
@testable import Friendji

class GameViewModelTests: XCTestCase {
    
    // MARK: - Properties
    var sut: GameViewModel?

    
    
    // MARK: - Overrides
    override func setUp() {
        super.setUp()
        let player = Player(gender: .male, name: "name", age: .a, favoriteColor: "color", favoriteFruit: "fruit", phoneNumber: "phone number", pictureImageURL: "url")
        let gameModel = GameModel(hearts: .three, gameResult: .nameSharing, player: player, isMatch: true)
        sut = GameViewModel(gameModel: gameModel)
    }
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    
    
    // MARK: - Methods
    func testHeartStringReturnCorrectString() {
        XCTAssertEqual(sut?.heartsString, "❤️❤️❤️", "heartsString not working")
        sut?.gameModel.hearts = .one
        XCTAssertEqual(sut?.heartsString, "❤️💛💛", "heartsString not working")
    }



}
