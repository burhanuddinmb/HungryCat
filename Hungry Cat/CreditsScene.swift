//
//  CreditsScene.swift
//  TurtleSurvival
//
//  Created by student on 10/15/17.
//  Copyright © 2017 Student. All rights reserved.
//

import Foundation
import AVFoundation
import SpriteKit

//Class to display CreditsScene
class CreditsScene: SKScene
{
    //Mark: - Variable declarations -
    
    //Sound
    let popSound = Bundle.main.url(forResource: "ButtonPress", withExtension: "mp3")
    var audioPlayer = AVAudioPlayer()
    
    //Mark: - Functions -
    //Initialization
    override func didMove(to view: SKView)
    {
        //Background music
        let backgroundMusic = SKAudioNode(fileNamed: "background.mp3")
        backgroundMusic.autoplayLooped = true
        addChild(backgroundMusic)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch in touches
        {
            let location = touch.location(in: self);
            
            if atPoint(location).name == "Home"
            {
                do
                {
                    audioPlayer = try AVAudioPlayer(contentsOf: popSound!)
                    audioPlayer.play()
                }
                catch
                {
                    print("couldn't load sound file")
                }
                if let scene = HomeScene(fileNamed: "MainMenu")
                {
                    scene.scaleMode = .aspectFill
                    view!.presentScene(scene)
                }
            }
        }        
    }
}
