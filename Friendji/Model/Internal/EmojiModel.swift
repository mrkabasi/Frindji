//
//  EmojiModel.swift
//  Friendji
//
//  Created by Kasra Abasi on 8/2/19.
//  Copyright © 2019 kasraabasi. All rights reserved.
//

/// This a Model to pass around and have data to represent an emoji.

import Foundation

struct EmojiModel {
    
    // MARK: - Inner Types
    enum Eyes: Int {
        case open
        case close
    }
    enum Eyebrows: Int {
        case relax
        case normal
        case frown
        
        func relaxerEyebrow() -> Eyebrows {
            return Eyebrows(rawValue: rawValue - 1) ?? .relax
        }
        func frownerEyebrow() -> Eyebrows {
            return Eyebrows(rawValue: rawValue + 1) ?? .frown
        }
    }
    enum Mouth: Int {
        case frown
        case neutral
        case smile
        
        func sadderMouth() -> Mouth {
            return Mouth(rawValue: rawValue - 1) ?? .frown
        }
        func happierMouth() -> Mouth {
            return Mouth(rawValue: rawValue + 1) ?? .smile
        }
    }
    
    
    
    // MARK: - Properties
    var eyes: Eyes
    var eyeBrows: Eyebrows
    var mouth: Mouth
    
}
