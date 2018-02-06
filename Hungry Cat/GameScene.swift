//
//  GameScene
//  SpriteExperiment
//
//  Created by student on 24/09/17.
//  Copyright © 2017 Student. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation

class GameScene: SKScene, SKPhysicsContactDelegate
{
    //Mark: - Variable declarations -
    //Track stars collected
    var starCollected: Int = 0
    var star: SKSpriteNode! // star Object
    
    //Variables for Rat movement
    var rat: SKSpriteNode!
    var isFingerOnRat = false
    var lastTouch: CGPoint? = nil

    //Track motions
    var buttonPressed: Bool = false
    
    //Animation
    var catAnimatedFrames: [SKTexture]!
    var animatingFrames = [SKTexture]()
    
    //Physics bodies
    var cat: SKSpriteNode!
    var timeLabel = SKLabelNode()
    
    //Keep track of cat position
    var catPosition:CGPoint!
    
    //Cat emitter
    var particles: SKEmitterNode!
    
    //Game paused/resume
    var pause: SKSpriteNode?
    var resume: SKSpriteNode?
    var mainMenu: SKSpriteNode?
    var gamePaused: Bool = false
    var gameStarted: Bool = false
    
    //Font SKNode
    var node: CustomFont!
    
    //Sound
    var audioPlayer:AVAudioPlayer?
    
    //Mark: - Variable declarations -
    //Initialization
    override func didMove(to view: SKView)
    {
        super.didMove(to: view)
        //Background music
        let backgroundMusic = SKAudioNode(fileNamed: "background.mp3")
        backgroundMusic.autoplayLooped = true
        addChild(backgroundMusic)
        
        do
        {
            audioPlayer = try AVAudioPlayer (contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "movablePlatform", ofType: "wav")!))
        }
        catch {
            print ("error")
        }
        
        //Edge frame
        let edgeFrame = CGRect(origin: CGPoint(x: 0 ,y: 0), size: CGSize(width: (self.view?.frame.width)!, height: (self.view?.frame.height)!))
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: edgeFrame)
        
        //Time
        TimeCalculation.levelTimer.resetTimer()
        let nodePos = CGPoint(x: 250, y: 20)
        node = CustomFont(fontNamed: "Arcena", text: "Time: ", fontSize: 60, fontColor: SKColor.white, position: nodePos, zPosition: 5)
        addChild(node!)
        
        //Rat physics
        rat = childNode(withName: "Rat") as! SKSpriteNode
        rat.physicsBody!.usesPreciseCollisionDetection = true
        rat.physicsBody!.categoryBitMask = PhysicsCategory.Rat
        rat.physicsBody!.collisionBitMask = PhysicsCategory.Block | PhysicsCategory.Food | PhysicsCategory.Trap | PhysicsCategory.Button | PhysicsCategory.Chocolate
        rat.zPosition = VisualPosition.Rat
        
        //Cat physics
        cat = childNode(withName: "Cat") as! SKSpriteNode
        cat.physicsBody!.categoryBitMask = PhysicsCategory.Cat
        cat.physicsBody!.collisionBitMask = PhysicsCategory.Food
        cat.physicsBody!.contactTestBitMask = PhysicsCategory.Food | PhysicsCategory.Chocolate
        cat.zPosition = VisualPosition.Cat
        catPosition = cat.position
        
        //Particle Emitter
        particles = SKEmitterNode(fileNamed: "CatIdle.sks")
        particles.setScale(0.18)
        particles.zPosition = 10
        particles.position = catPosition
        addChild(particles)
        
        //Block physics
        enumerateChildNodes(withName: "Block")
        {
            node, stop in
            let block = node as! SKSpriteNode
            block.physicsBody!.categoryBitMask = PhysicsCategory.Block
            block.physicsBody!.collisionBitMask = PhysicsCategory.Rat | PhysicsCategory.Cat | PhysicsCategory.Food | PhysicsCategory.Chocolate
            block.physicsBody!.usesPreciseCollisionDetection = true
            block.zPosition = VisualPosition.Block
        }
        
        //Star physics
        enumerateChildNodes(withName: "Star")
        {
            node, stop in
            let star = node as! SKSpriteNode
            star.physicsBody!.categoryBitMask = PhysicsCategory.Star
            star.physicsBody!.contactTestBitMask = PhysicsCategory.Food
            star.physicsBody!.collisionBitMask = 0
            star.zPosition = VisualPosition.Star
            let movAction1 = SKAction.scale(by: 0.8, duration: 0.2)
            let movAction2 = SKAction.scale(by: 1.25, duration: 0.2)
            let movAction3 = SKAction.move(by: CGVector(dx: 1, dy: 0), duration: 0.1)
            let movAction4 = SKAction.move(by: CGVector(dx: -2, dy: 0), duration: 0.1)
            let movAction5 = SKAction.move(by: CGVector(dx: 2, dy: 0), duration: 0.1)
            let movAction6 = SKAction.move(by: CGVector(dx: -1, dy: 0), duration: 0.1)
            star.run(SKAction.repeatForever(
                    SKAction.sequence([
                    movAction1,
                    movAction2,
                    movAction3,
                    movAction4,
                    movAction5,
                    movAction4,
                    movAction5,
                    movAction6,
                    SKAction.wait(forDuration: 0.6)
                    ])
            ))
        }
        
        //Cheese physics
        enumerateChildNodes(withName: "Cheese")
        {
            node, stop in
            let cheese = node as! SKSpriteNode
            cheese.physicsBody!.categoryBitMask = PhysicsCategory.Cheese
            cheese.physicsBody!.collisionBitMask = PhysicsCategory.Food | PhysicsCategory.Chocolate
            cheese.physicsBody!.usesPreciseCollisionDetection = true
            cheese.zPosition = VisualPosition.Block
        }
        
        //Trap physics
        enumerateChildNodes(withName: "Trap")
        {
            node, stop in
            let trap = node as! SKSpriteNode
            trap.physicsBody!.categoryBitMask = PhysicsCategory.Trap
            trap.physicsBody!.collisionBitMask = PhysicsCategory.Rat
            trap.physicsBody!.usesPreciseCollisionDetection = true
            trap.zPosition = VisualPosition.Block
        }
        
        //Food physics
        enumerateChildNodes(withName: "Food")
        {
            node, stop in
            let food = node as! SKSpriteNode
            food.physicsBody!.categoryBitMask = PhysicsCategory.Food
            food.physicsBody!.contactTestBitMask = PhysicsCategory.Cat | PhysicsCategory.Star
            food.physicsBody!.collisionBitMask = PhysicsCategory.Rat | PhysicsCategory.Cat |  PhysicsCategory.Block | PhysicsCategory.Cheese | PhysicsCategory.Chocolate
            food.physicsBody!.usesPreciseCollisionDetection = true
            food.zPosition = VisualPosition.Food
            print("foodfound")
        }
        
        //Chocolate physics
        enumerateChildNodes(withName: "Chocolate")
        {
            node, stop in
            let chocolate = node as! SKSpriteNode
            chocolate.physicsBody!.categoryBitMask = PhysicsCategory.Chocolate
            chocolate.physicsBody!.collisionBitMask = PhysicsCategory.Block | PhysicsCategory.Food | PhysicsCategory.Cheese | PhysicsCategory.Rat | PhysicsCategory.Cat |
                PhysicsCategory.Chocolate
            chocolate.physicsBody!.contactTestBitMask = PhysicsCategory.Button | PhysicsCategory.Cat
            chocolate.physicsBody!.usesPreciseCollisionDetection = true
            chocolate.zPosition = VisualPosition.Block
        }
        
        //only level2 elements
        if (LevelScore.levelNumber == 2)
        {
            print ("level2")
            //ButtonHolder physics
            let buttonHolder = childNode(withName: "ButtonHolder") as! SKSpriteNode
            buttonHolder.physicsBody!.categoryBitMask = PhysicsCategory.Block
            buttonHolder.physicsBody!.collisionBitMask = PhysicsCategory.Food | PhysicsCategory.Rat | PhysicsCategory.Chocolate
            buttonHolder.zPosition = VisualPosition.Block
            
            //Button physics
            let button = childNode(withName: "Button") as! SKSpriteNode
            button.physicsBody!.categoryBitMask = PhysicsCategory.Button
            button.physicsBody!.collisionBitMask = PhysicsCategory.Food | PhysicsCategory.Rat | PhysicsCategory.Chocolate
            button.physicsBody!.contactTestBitMask = PhysicsCategory.Chocolate
            button.physicsBody!.usesPreciseCollisionDetection = true
            button.zPosition = VisualPosition.Block - 1

            //Movable block physics
            let movableBlock = childNode(withName: "MovableBlock") as! SKSpriteNode
            movableBlock.physicsBody!.categoryBitMask = PhysicsCategory.Block
            movableBlock.physicsBody!.collisionBitMask = PhysicsCategory.Food | PhysicsCategory.Rat
            movableBlock.physicsBody!.contactTestBitMask = PhysicsCategory.Chocolate
            movableBlock.physicsBody!.usesPreciseCollisionDetection = true
            movableBlock.zPosition = VisualPosition.Block - 1
        }
        //only level4 elements
        else if(LevelScore.levelNumber == 4) {
            //Block that rotates
            let rotatoBlock = childNode(withName: "RotatoBlock") as! SKSpriteNode
            rotatoBlock.physicsBody!.usesPreciseCollisionDetection = true
            rotatoBlock.physicsBody!.categoryBitMask = PhysicsCategory.Block
            rotatoBlock.physicsBody!.collisionBitMask = PhysicsCategory.Food | PhysicsCategory.Chocolate | PhysicsCategory.Rat
            rotatoBlock.zPosition = VisualPosition.Rat
        }
        physicsWorld.contactDelegate =  self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        
        for touch in touches
        {
            let location = touch.location(in: self);

            if (gamePaused)
            {
                if atPoint(location).name == "Resume"
                {
                    ResumeGame()
                }
                else if atPoint(location).name == "MainMenu"
                {
                    if let scene = HomeScene(fileNamed: "MainMenu")
                    {
                        scene.scaleMode = .aspectFill
                        view!.presentScene(scene)//, transition: SKTransition.doorway(withDuration: 2))
                    }
                }
                else
                {
                    return
                }
            }
            
            if atPoint(location).name == "Pause"
            {
                PauseGame()
            }
            else if atPoint(location).name == "Rat"
            {
                if (!TimeCalculation.levelTimer.isTimerRunning)
                {
                    gameStarted = true
                    TimeCalculation.levelTimer.startTimer()
                }
                isFingerOnRat = true
            }

            else if atPoint(location).name == "Retry"
            {
                if let scene = GameScene(fileNamed: "Level\(LevelScore.levelNumber)Scene")
                {
                  //  timeLabel.removeFromParent
                    node.removeFromParent()
                    TimeCalculation.levelTimer.resetTimer()
                    scene.scaleMode = .aspectFill
                    view!.presentScene(scene)//, transition: SKTransition.moveIn(with: .up, duration: 1))
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        // Rat movement part1
        if isFingerOnRat
        {
            let touch = touches.first
            
            rat.physicsBody!.affectedByGravity = false
            let touchLocation = touch!.location(in: self)
            lastTouch = touchLocation
            let previousLocation = touch!.previousLocation(in: self)
            let ratX = (touchLocation.x - previousLocation.x)
            let ratY = (touchLocation.y - previousLocation.y)
            rat.physicsBody!.applyImpulse(CGVector(dx: ratX, dy:ratY))
        }
    }
    
    override func update(_ currentTime: CFTimeInterval)
    {
        // Only add an impulse if there's a lastTouch stored
        // Rat movement part2
        if isFingerOnRat
        {
            if let touch = lastTouch
            {
                rat.physicsBody?.velocity = CGVector(dx: (touch.x - rat.position.x) * 8, dy: (touch.y - rat.position.y) * 8)
            }
        }
        
        //Time adjustment
        node.text = "Time: " + String(TimeCalculation.levelTimer.time)
        if (TimeCalculation.levelTimer.time == 0)
        {
            GameOver()
        }
        
        //Movement for level2
        if (buttonPressed)
        {
            moveLog()
        }
        
        //If game goes in background
        if (GameState.paused && !gamePaused)
        {
            PauseGame()
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        isFingerOnRat = false
        rat.physicsBody!.affectedByGravity = true
    }
    
    //Handle food collision with star
    func foodCollideWithStar(star: SKSpriteNode, chocolate: SKSpriteNode)
    {
        starCollected += 1
        print("Stars collected \(starCollected)")
        star.removeFromParent()
    }
    
    //Handle food collision with cat
    func foodCollideWithCat(cat: SKSpriteNode, food: SKSpriteNode)
    {
        do
        {
            audioPlayer = try AVAudioPlayer (contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Munch", ofType: "wav")!))
            audioPlayer?.play()
        }
        catch {
            print ("error")
        }
        food.removeFromParent()
        particles.removeFromParent()
        catAnimation()
    }
    
    //Cat animation with level finish
    func catAnimation()
    {
        let CatAnimatedAtlas: SKTextureAtlas = SKTextureAtlas(named: "CatImages")

        let numImages = CatAnimatedAtlas.textureNames.count
        cat.removeFromParent()
        for i in 1...numImages
        {
            animatingFrames.append(CatAnimatedAtlas.textureNamed("cat\(i)"))
        }
        catAnimatedFrames = animatingFrames

        let temp: SKTexture = catAnimatedFrames[0]
        cat = SKSpriteNode(texture: temp)

        let moveAction2 = SKAction.animate(with: catAnimatedFrames, timePerFrame: 0.20)
        TimeCalculation.levelTimer.pauseTimer()
        timeLabel.removeFromParent()
        cat.run(SKAction.sequence([moveAction2]), completion: levelEnd)
        cat.zPosition = VisualPosition.Cat
        cat.position = catPosition
        addChild(cat)
    }
    
    //Finish level when win
    func levelEnd()
    {
        if let scene = LevelTransition(fileNamed: "LevelTransition")
        {
            scene.scaleMode = .aspectFill
            addLevelScore(score: starCollected)
            view!.presentScene(scene, transition: SKTransition.moveIn(with: .up, duration: 1))
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact)
    {
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask
        {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }
        else
        {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        //Releasing the button
        if ((firstBody.categoryBitMask & PhysicsCategory.Button != 0) &&
            (secondBody.categoryBitMask & PhysicsCategory.Chocolate != 0))
        {
            audioPlayer?.stop()
            self.buttonPressed = false
            let button = self.childNode(withName: "Button") as! SKSpriteNode
            button.run(SKAction.move(by: CGVector(dx: 0, dy: 8), duration: 0.2))
        }
    }
    
   func didBegin(_ contact: SKPhysicsContact)
    {
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask
        {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }
        else
        {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        //Stars collection
        if ((firstBody.categoryBitMask & PhysicsCategory.Food != 0) &&
            (secondBody.categoryBitMask & PhysicsCategory.Star != 0))
        {
            if let chocolate = firstBody.node as? SKSpriteNode, let
                star = secondBody.node as? SKSpriteNode
            {
                foodCollideWithStar(star: star, chocolate: chocolate)
            }
        }
        //Feeding the Cat
        else if ((firstBody.categoryBitMask & PhysicsCategory.Food != 0) &&
            (secondBody.categoryBitMask & PhysicsCategory.Cat != 0))
        {
            if let food = firstBody.node as? SKSpriteNode, let
                cat = secondBody.node as? SKSpriteNode
            {
                foodCollideWithCat(cat: cat, food: food)
            }
        }
        //Pressing the button
        else if ((firstBody.categoryBitMask & PhysicsCategory.Button != 0) &&
            (secondBody.categoryBitMask & PhysicsCategory.Chocolate != 0))
        {
            print("Contact begin")
            buttonPressed = true;
            let button = childNode(withName: "Button") as! SKSpriteNode
            button.run(SKAction.sequence([SKAction.move(by: CGVector(dx: 0, dy: -8), duration: 0.2)]))
        }
        else if ((firstBody.categoryBitMask & PhysicsCategory.Cat != 0) &&
            (secondBody.categoryBitMask & PhysicsCategory.Chocolate != 0))
        {
            let chocolate = secondBody.node as? SKSpriteNode
            chocolate?.removeFromParent()
            GameOver()
        }
    }
    
    //Move movable block in level2
    func moveLog()
    {
        if (!((audioPlayer?.isPlaying)!))
        {
            audioPlayer?.play()
        }
        let movableBlock = childNode(withName: "MovableBlock") as! SKSpriteNode
        movableBlock.position = CGPoint(x:movableBlock.position.x, y:movableBlock.position.y+2)
    }
    
    //Game lost
    func GameOver()
    {
        do
        {
            audioPlayer = try AVAudioPlayer (contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "meow", ofType: "wav")!))
            audioPlayer?.play()
        }
        catch {
            print ("error")
        }
        if let scene = GameOverScene(fileNamed: "GameoverScene")
        {
            scene.scaleMode = .aspectFill
            view!.presentScene(scene, transition: SKTransition.moveIn(with: .up, duration: 1))
        }
    }
    
    //Pause game
    func PauseGame() {
        gamePaused = true
        pause = SKSpriteNode (imageNamed: "PauseBG")
        pause?.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        pause?.setScale(0.4)
        pause?.zPosition = 100
        addChild(pause!)
        
        resume = SKSpriteNode() // You should already have it
        resume?.name = "Resume"
        resume?.alpha = 0.01
        resume?.color = UIColor.white
        resume?.position  = CGPoint(x: size.width * 0.5, y: size.height * 0.55)
        resume?.size = CGSize(width: 260, height: 80)
        resume?.zPosition = 101
        addChild(resume!)
        
        mainMenu = SKSpriteNode() // You should already have it
        mainMenu?.name = "MainMenu"
        mainMenu?.alpha = 0.01
        mainMenu?.color = UIColor.white
        mainMenu?.position  = CGPoint(x: size.width * 0.5, y: size.height * 0.4)
        mainMenu?.size = CGSize(width: 260, height: 80)
        mainMenu?.zPosition = 101
        addChild(mainMenu!)
        scene?.physicsWorld.speed = 0.0
        TimeCalculation.levelTimer.pauseTimer()
    }
    
    //Resume the game
    func ResumeGame() {
        if (GameState.paused)
        {
            GameState.paused = false
        }
        scene?.physicsWorld.speed = 1.0
        if (gameStarted)
        {
            TimeCalculation.levelTimer.startTimer()
        }
        print("Resume")
        gamePaused = false
        pause?.removeFromParent()
        resume?.removeFromParent()
    }
}
