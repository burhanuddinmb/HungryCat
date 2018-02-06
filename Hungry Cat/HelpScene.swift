//
//  HelpScene.swift
//  TurtleSurvival
//
//  Created by NandhiniSathish on 11/10/17.
//  Copyright © 2017 Student. All rights reserved.
//

import Foundation
import AVFoundation

import SpriteKit

class HelpScene: SKScene
{
    //Mark: - Variable declarations -
    //Sound
    let popSound = Bundle.main.url(forResource: "ButtonPress", withExtension: "mp3")
    var audioPlayer = AVAudioPlayer()
    
    //Trackpage
    var isFirstPage:Bool = true
    
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

            else if atPoint(location).name == "Next"
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
                let menu2 = childNode(withName: "HelpMenu2") as? SKSpriteNode
                
                //Switch images for help
                if (isFirstPage){
                    isFirstPage = false
                    menu2!.zPosition = 1
                }
                else
                {
                    isFirstPage = true
                    menu2!.zPosition = -1
                }
            }
        }        
    }
}
