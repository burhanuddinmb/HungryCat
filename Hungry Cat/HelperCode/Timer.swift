//
//  Timer.swift
//  Hungry Cat
//
//  Created by student on 12/9/17.
//  Copyright © 2017 RIT class. All rights reserved.
//

import Foundation

//Keep track of time in game
class TimeCalculation {
    var timer = Timer()
    var time:Int!
    {
        didSet {
            if (time < 0)
            {
                time = 0
            }
        }
    }
    var isTimerRunning: Bool = false
    
    //Singleton
    private init() {}
    static var levelTimer = TimeCalculation()
    
    //Start the timer
    func startTimer() {
        isTimerRunning = true
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    //Reset timer to its respective level time
    func resetTimer()
    {
        pauseTimer()
        switch(LevelScore.levelNumber)
        {
        case 1:
            time = 20
        case 2:
            time = 20
        case 3:
            time = 25
        case 4:
            time = 25
        case 5:
            time = 30
        default:
            print("Error level number")
        }
    }
    
    //Pause timer when game pauses/when the game just starts
    func pauseTimer() {
        isTimerRunning = false
        timer.invalidate()
    }
    
    //Update time per second
    @objc func updateTime() {
        time = time - 1
        if (time <= 0)
        {
            pauseTimer()
        }
    }
}
