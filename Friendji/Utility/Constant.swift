//
//  Constant.swift
//  Friendji
//
//  Created by Kasra Abasi on 8/2/19.
//  Copyright © 2019 kasraabasi. All rights reserved.
//

import UIKit

struct Constant {
    
    struct String {
        
        struct SegueID {
            static let signup = "ShowSignupViewControllerID"
            static let game = "ShowGameViewControllerID"
            static let prize = "ShowPrizeViewControllerID"
            static let unwindToHome = "unwindToHomeViewControllerWithSegueID"
        }
        
        struct UserDefault {
            static let isRegistered = "isRegistered"
        }
        
    }
    
    struct Number {
        static let skullRadiusToEyeOffset: CGFloat = 3
        static let skullRadiusToEyeRadus: CGFloat = 10
        static let skullRadiusToMouthWidth: CGFloat = 1
        static let skullRadiusToMouthHeight: CGFloat = 3
        static let skullRadiusToMouthOffset: CGFloat = 3
        static let skullRadiusToBrowOffset: CGFloat = 5
    }
    
    struct Color {
        static let fjDarkGray = UIColor(named: "FJDarkGray")!
        static let fjYellow = UIColor(named: "FJYellow")!
    }
    
}
