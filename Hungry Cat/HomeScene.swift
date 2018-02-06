//
//  HomeScene.swift
//  SpriteExperiment
//
//  Created by NandhiniSathish on 24/09/17.
//  Copyright © 2017 Student. All rights reserved.
//

import SpriteKit
import AVFoundation

class HomeScene: SKScene
{
    //Mark: - Variable declarations -
    //Sound
    let popSound = Bundle.main.url(forResource: "ButtonPress", withExtension: "mp3")
    var audioPlayer = AVAudioPlayer()
    
    //Mark: - Functions -
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
            
            if atPoint(location).name == "Play"
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
                
                if let scene = LevelSelectionScene(fileNamed: "LevelSelectionScene")
                {
                    scene.scaleMode = .aspectFill
                    view!.presentScene(scene)
                }
            }
            if atPoint(location).name == "Help"
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
                if let scene = HelpScene(fileNamed: "HelpMenuScene")
                {
                    scene.scaleMode = .aspectFill
                    view!.presentScene(scene)
                }
            }
            if atPoint(location).name == "Credits"
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
                if let scene = HelpScene(fileNamed: "CreditsScene")
                {
                    scene.scaleMode = .aspectFill
                    view!.presentScene(scene)
                }
            }
        }
    }    
}
