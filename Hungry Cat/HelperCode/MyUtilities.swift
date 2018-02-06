//
//  MyUtilities.swift
//  Hungry Cat
//
//  Created by student on 12/8/17.
//  Copyright © 2017 RIT class. All rights reserved.
//

import Foundation
import SpriteKit

//Global variable to handle game pausing when it enters background
struct GameState {
    static var paused:Bool = false
}

//Physics category of objects
struct PhysicsCategory
{
    static let None         : UInt32 = 0b0
    static let Rat          : UInt32 = 0b1000000000    // 512
    static let Food         : UInt32 = 0b10            // 2
    static let Cat          : UInt32 = 0b100           // 4
    static let Star         : UInt32 = 0b1000          // 8
    static let Block        : UInt32 = 0b10000         // 16
    static let Trap         : UInt32 = 0b100000        // 32
    static let Cheese       : UInt32 = 0b1000000       // 64
    static let Button       : UInt32 = 0b10000000      // 128
    static let Chocolate    : UInt32 = 0b100000000     // 256
}

//zPositions of objects
struct VisualPosition
{
    static let Background: CGFloat = 0
    static let Food: CGFloat = 1
    static let Star: CGFloat = 2
    static let Block: CGFloat = 4 // Same as trap and cheese
    static let Cat: CGFloat = 5
    static let Rat: CGFloat = 11
    static let Timer: CGFloat = 10
}

//Function to add score to the respective level
func addLevelScore(score: Int) {
    
    switch (LevelScore.levelNumber)
    {
    case 1:
        LevelScore.sharedData.level1Complete = true
        if (LevelScore.sharedData.level1Stars < score)
        {
            LevelScore.sharedData.level1Stars = score
        }
    case 2:
        LevelScore.sharedData.level2Complete = true
        if (LevelScore.sharedData.level2Stars < score)
        {
            LevelScore.sharedData.level2Stars = score
        }
    case 3:
        LevelScore.sharedData.level3Complete = true
        if (LevelScore.sharedData.level3Stars < score)
        {
            LevelScore.sharedData.level3Stars = score
        }
    case 4:
        LevelScore.sharedData.level4Complete = true
        if (LevelScore.sharedData.level4Stars < score)
        {
            LevelScore.sharedData.level4Stars = score
        }
    case 5:
        LevelScore.sharedData.level5Complete = true
        if (LevelScore.sharedData.level5Stars < score)
        {
            LevelScore.sharedData.level5Stars = score
        }
    default:
        print("Error level number")
    }
    LevelScore.levelScore = score
}
