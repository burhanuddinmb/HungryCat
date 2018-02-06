//
//  LevelScore.swift
//  Hungry Cat
//
//  Created by student on 12/1/17.
//  Copyright © 2017 RIT class. All rights reserved.
//

import Foundation

class LevelScore
{
    //Singleton
    private init()
    {
        readDefaultsData()
        print("Created LevelScore instance")
    }
    static let sharedData = LevelScore()
    
    // Keep track of the level
    static var levelNumber:Int = 0
    
    //Keep track of score of the current level
    static var levelScore:Int = 0
    
    //Mark: - Variables for level completions and their strs collected -
    let level1CompleteKey = "level1CompleteKey"
    var level1Complete:Bool = false
    {
        didSet
        {
            //Store value in memory
            let defaults = UserDefaults.standard
            defaults.set(level1Complete, forKey: level1CompleteKey)
        }
    }
    let level1StarsKey = "level1StarsKey"
    var level1Stars:Int = 0
    {
        didSet
        {
            //Store value in memory
            let defaults = UserDefaults.standard
            defaults.set(level1Stars, forKey: level1StarsKey)
        }
    }
    
    let level2CompleteKey = "level2CompleteKey"
    var level2Complete:Bool = false
    {
        didSet
        {
            //Store value in memory
            let defaults = UserDefaults.standard
            defaults.set(level2Complete, forKey: level2CompleteKey)
        }
    }
    let level2StarsKey = "level2StarsKey"
    var level2Stars:Int = 0 {
        didSet{
            //Store value in memory
            let defaults = UserDefaults.standard
            defaults.set(level2Stars, forKey: level2StarsKey)
        }
    }
    
    let level3CompleteKey = "level3CompleteKey"
    var level3Complete:Bool = false
    {
        didSet
        {
            //Store value in memory
            let defaults = UserDefaults.standard
            defaults.set(level3Complete, forKey: level3CompleteKey)
        }
    }
    let level3StarsKey = "level3StarsKey"
    var level3Stars:Int = 0 {
        didSet{
            //Store value in memory
            let defaults = UserDefaults.standard
            defaults.set(level3Stars, forKey: level3StarsKey)
        }
    }
    
    let level4CompleteKey = "level4CompleteKey"
    var level4Complete:Bool = false
    {
        didSet
        {
            //Store value in memory
            let defaults = UserDefaults.standard
            defaults.set(level4Complete, forKey: level4CompleteKey)
        }
    }
    let level4StarsKey = "level4StarsKey"
    var level4Stars:Int = 0 {
        didSet{
            //Store value in memory
            let defaults = UserDefaults.standard
            defaults.set(level4Stars, forKey: level4StarsKey)
        }
    }
    
    let level5CompleteKey = "level5CompleteKey"
    var level5Complete:Bool = false
    {
        didSet
        {
            //Store value in memory
            let defaults = UserDefaults.standard
            defaults.set(level5Complete, forKey: level5CompleteKey)
        }
    }
    let level5StarsKey = "level5StarsKey"
    var level5Stars:Int = 0 {
        didSet{
            //Store value in memory
            let defaults = UserDefaults.standard
            defaults.set(level5Stars, forKey: level5StarsKey)
        }
    }
    
    //Fetch falue from memory
    private func readDefaultsData()
    {
        let defaults = UserDefaults.standard
        level1Complete = defaults.bool(forKey: level1CompleteKey)
        level2Complete = defaults.bool(forKey: level2CompleteKey)
        level3Complete = defaults.bool(forKey: level3CompleteKey)
        level4Complete = defaults.bool(forKey: level4CompleteKey)
        level5Complete = defaults.bool(forKey: level5CompleteKey)
        level1Stars = defaults.integer(forKey: level1StarsKey)
        level2Stars = defaults.integer(forKey: level2StarsKey)
        level3Stars = defaults.integer(forKey: level3StarsKey)
        level4Stars = defaults.integer(forKey: level4StarsKey)
        level5Stars = defaults.integer(forKey: level5StarsKey)
    }
}
