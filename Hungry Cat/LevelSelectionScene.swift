import Foundation
import AVFoundation

import SpriteKit

class LevelSelectionScene: SKScene
{
    //Mark: - Variable declarations -
    //Sound
    let popSound = Bundle.main.url(forResource: "ButtonPress", withExtension: "mp3")
    var audioPlayer = AVAudioPlayer()

    //Levels unlocked
    var level2: Bool = true
    var level3: Bool = true
    var level4: Bool = true
    var level5: Bool = true
    
    //Mark: - Functions -
    override func didMove(to view: SKView)
    {
        //Background music
        let backgroundMusic = SKAudioNode(fileNamed: "background.mp3")
        backgroundMusic.autoplayLooped = true
        addChild(backgroundMusic)
        
        //Show stars and accessible levels
        print ("Level1Stars \(LevelScore.sharedData.level1Stars)")
        if (LevelScore.sharedData.level1Complete)
        {
            level2 = true
            let unlockedNumber = childNode(withName: "OnScreen2") as! SKSpriteNode
            unlockedNumber.zPosition = VisualPosition.Star
            for n in 0...LevelScore.sharedData.level1Stars{
                let star = childNode(withName: "Star1\(n)") as? SKSpriteNode
                star?.zPosition = VisualPosition.Star
            }
        }
        print ("Level2Stars \(LevelScore.sharedData.level2Stars)")
        if (LevelScore.sharedData.level2Complete)
        {
            let unlockedNumber = childNode(withName: "OnScreen3") as! SKSpriteNode
            unlockedNumber.zPosition = VisualPosition.Star
            level3 = true
            for n in 0...LevelScore.sharedData.level2Stars{
                let star = childNode(withName: "Star2\(n)") as? SKSpriteNode
                star?.zPosition = VisualPosition.Star
            }
        }
        print ("Level3Stars \(LevelScore.sharedData.level3Stars)")
        if (LevelScore.sharedData.level3Complete)
        {
            let unlockedNumber = childNode(withName: "OnScreen4") as! SKSpriteNode
            unlockedNumber.zPosition = VisualPosition.Star
            level4 = true
            for n in 0...LevelScore.sharedData.level3Stars{
                let star = childNode(withName: "Star3\(n)") as? SKSpriteNode
                star?.zPosition = VisualPosition.Star
            }
        }
        print ("Level4Stars \(LevelScore.sharedData.level4Stars)")
        if (LevelScore.sharedData.level4Complete)
        {
            let unlockedNumber = childNode(withName: "OnScreen5") as! SKSpriteNode
            unlockedNumber.zPosition = VisualPosition.Star
            level5 = true
            for n in 0...LevelScore.sharedData.level4Stars{
                let star = childNode(withName: "Star4\(n)") as? SKSpriteNode
                star?.zPosition = VisualPosition.Star
            }
        }
        print ("Level5Stars \(LevelScore.sharedData.level5Stars)")
        if (LevelScore.sharedData.level5Complete)
        {
            for n in 0...LevelScore.sharedData.level5Stars{
                let star = childNode(withName: "Star5\(n)") as? SKSpriteNode
                star?.zPosition = VisualPosition.Star
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch in touches
        {
            //Go to selected levels
            let location = touch.location(in: self);
            if atPoint(location).name == "Level1"
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
                if let scene = GameScene(fileNamed: "Level1Scene")
                {
                    LevelScore.levelNumber = 1
                    scene.scaleMode = .aspectFill
                    view!.presentScene(scene)
                }
            }
            if(level2)
            {
                if atPoint(location).name == "Level2"
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
                    if let scene = GameScene(fileNamed: "Level2Scene")
                    {
                        LevelScore.levelNumber = 2
                        scene.scaleMode = .aspectFill
                        view!.presentScene(scene)
                    }
                }
            }
            
            if(level3)
            {
                if atPoint(location).name == "Level3"
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
                    if let scene = GameScene(fileNamed: "Level3Scene")
                    {
                        LevelScore.levelNumber = 3
                        scene.scaleMode = .aspectFill
                        view!.presentScene(scene)
                    }
                }
            }
            if(level4)
            {
                if atPoint(location).name == "Level4"
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
                    if let scene = GameScene(fileNamed: "Level4Scene")
                    {
                        LevelScore.levelNumber = 4
                        scene.scaleMode = .aspectFill
                        view!.presentScene(scene)
                    }
                }
            }
            if(level5)
            {
                if atPoint(location).name == "Level5"
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
                    if let scene = GameScene(fileNamed: "Level5Scene")
                    {
                        LevelScore.levelNumber = 5
                        scene.scaleMode = .aspectFill
                        view!.presentScene(scene)
                    }
                }
            }
        }
    }
}
