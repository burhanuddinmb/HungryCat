

import Foundation

import SpriteKit

//The custom SKNode class for generation of time
//Our game does not really need a CustomSKNode
class CustomFont: SKNode
{
    var spriteLabel = SKLabelNode()
    var text:String!
    {
        didSet{
            spriteLabel.text = text
        }
    }
    
    init(fontNamed: String, text: String, fontSize: CGFloat, fontColor: SKColor, position: CGPoint, zPosition: CGFloat)
    {
        super.init()
        
        // Mark: Custom SKLabel
        spriteLabel = SKLabelNode()
        spriteLabel = SKLabelNode(fontNamed: fontNamed)
        spriteLabel.fontSize = fontSize
        spriteLabel.fontColor = fontColor
        spriteLabel.zPosition = zPosition
        spriteLabel.text = text
        spriteLabel.position = position

        self.addChild(spriteLabel)
        
        self.position = position
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


