//
//  GameOverScene.swift
//  SpriteExperiment
//
//  Created by Student on 9/11/17.
//  Copyright © 2017 Student. All rights reserved.
//

import AVFoundation
import SpriteKit

class GameOverScene: SKScene
{
    //Mark: - Variable declarations -
    //Stars
    var star1: SKSpriteNode!
    var star2: SKSpriteNode!
    var star3: SKSpriteNode!
    
    //Sound
    var audioPlayer = AVAudioPlayer()
    
    //Mark: - Functions -
    override func didMove(to view: SKView)
    {
        //GameOver music
        do
        {
            audioPlayer = try AVAudioPlayer (contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "gameOver", ofType: "wav")!))
            audioPlayer.play()
        }
        catch {
            print ("error")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch in touches
        {
            let location = touch.location(in: self);
            if atPoint(location).name == "MainMenu"
            {
                if let scene = HomeScene(fileNamed: "MainMenu")
                {
                    scene.scaleMode = .aspectFill
                    view!.presentScene(scene)
                }
            }
            if atPoint(location).name == "Retry"
            {
                if let scene = GameScene(fileNamed: "Level\(LevelScore.levelNumber)Scene")
                {
                    scene.scaleMode = .aspectFill
                    view!.presentScene(scene)
                }
            }
        }
    }
}
