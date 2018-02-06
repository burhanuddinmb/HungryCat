import Foundation
import AVFoundation
import SpriteKit

class LevelTransition: SKScene
{
    //Mark: - Variable declarations -
    //Stars collected
    var star1: SKSpriteNode!
    var star2: SKSpriteNode!
    var star3: SKSpriteNode!
    
    //Player animations
    var starAnimatingFrames: [SKTexture]!
    var animatingFrames = [SKTexture]()
    
    //Sound
    let popSound = Bundle.main.url(forResource: "ButtonPress", withExtension: "mp3")
    var audioPlayer = AVAudioPlayer()
    
    //Mark: - Functions -
    override func didMove(to view: SKView)
    {
        //Background music
        do
        {
            audioPlayer = try AVAudioPlayer (contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "levelComplete", ofType: "wav")!))
            audioPlayer.play()
        }
        catch {
            print ("error")
        }

        //After finishing last level, show credits instead of next
        if (LevelScore.levelNumber == 5)
        {
            let credits = childNode(withName: "Credits") as! SKSpriteNode
            credits.zPosition = 1
        }
        starAnimated()
    }
    
    //Show number of stars achieved in stage
    func starAnimated()
    {
        star1 = SKSpriteNode(imageNamed: "starBig")
        star2 = SKSpriteNode(imageNamed: "starBig")
        star3 = SKSpriteNode(imageNamed: "starBig")

        let when = DispatchTime.now() + 1
        DispatchQueue.main.asyncAfter(deadline: when) {
            if(LevelScore.levelScore > 0)
            {

                  self.star1.position = CGPoint(x: 414.733, y: 395.753)
                  self.star1.zPosition = VisualPosition.Star
                  self.addChild(self.star1)
                  let moveAction1 = SKAction.scale(by: 0.45, duration: 0.6)
                  self.star1.run( SKAction.sequence([moveAction1]))
            }
            DispatchQueue.main.asyncAfter(deadline: when + 0.5)
            {
                if(LevelScore.levelScore > 1)
                {
                    let moveAction2 = SKAction.scale(by: 0.45, duration: 0.6)
                    self.star2.position = CGPoint(x: 508.118, y: 394.754)
                    self.star2.zPosition = VisualPosition.Star
                    self.star2.run(SKAction.sequence([moveAction2]))
                    self.addChild(self.star2)
                }

                DispatchQueue.main.asyncAfter(deadline: when + 1)
                {
                    if(LevelScore.levelScore > 2)
                    {
                        let moveAction3 = SKAction.scale(by: 0.45, duration: 0.6)
                        self.star3.position = CGPoint(x: 600.0, y: 394.755)
                        self.star3.zPosition = VisualPosition.Star
                        self.star3.run(SKAction.sequence([moveAction3]))
                        self.addChild(self.star3)
                    }
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch in touches
        {
            let location = touch.location(in: self);
            if atPoint(location).name == "Next"
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

                if (LevelScore.levelNumber >= 5)
                {
                    if let scene = CreditsScene(fileNamed: "CreditsScene")
                    {
                        scene.scaleMode = .aspectFill
                        view!.presentScene(scene)
                    }
                }
                else{
                    LevelScore.levelNumber += 1
                    if let scene = GameScene(fileNamed: "Level\(LevelScore.levelNumber)Scene")
                    {
                        scene.scaleMode = .aspectFill
                        view!.presentScene(scene)
                    }
                }
                
            }
            if atPoint(location).name == "Retry"
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
                if let scene = GameScene(fileNamed: "Level\(LevelScore.levelNumber)Scene")
                {
                    scene.scaleMode = .aspectFill
                    view!.presentScene(scene)
                }
            }
            if atPoint(location).name == "MainMenu"
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

