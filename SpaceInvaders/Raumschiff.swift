//
//  Raumschiff.swift
//  SpaceInvaders
//
//  Created by Zoltán Gál on 2019. 10. 07..
//  Copyright © 2019. Zoltán Gál. All rights reserved.
//

import SpriteKit

class Raumschiff : SKSpriteNode {
    var szene : SKScene!
    
    init() {
        let bild = SKTexture(imageNamed: "verteidiger")
        super.init(texture: bild, color: NSColor.black, size: bild.size())
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.categoryBitMask = 0b1
        self.physicsBody?.contactTestBitMask = 0b11 | 0b10
        self.physicsBody?.collisionBitMask = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setzePosition(szene: SKScene) {
        self.szene = szene
        position = CGPoint(x: szene.frame.midX, y: CGFloat(20))
        self.szene.addChild(self)
    }
    
    func bewegen(rictung :Int) {
        if position.x > 50 && rictung == -1 {
            run(SKAction.move(by: CGVector(dx: -10, dy: 0), duration: 0.3))
        }
        
        if position.x < szene.frame.maxX - 50 && rictung == 1 {
            run(SKAction.move(by: CGVector(dx: 10, dy: 0), duration: 0.3))
        }
    }
    
    func feuern() {
        let munitionSprite = SKSpriteNode(imageNamed: "munition_verteidiger")
        munitionSprite.name = "raumschiffGeschoss"
        munitionSprite.position = CGPoint(x: frame.midX, y: frame.maxY)
        szene.addChild(munitionSprite)
        
        munitionSprite.physicsBody = SKPhysicsBody(rectangleOf: munitionSprite.size)
        munitionSprite.physicsBody?.categoryBitMask = 0b1000
        munitionSprite.physicsBody?.collisionBitMask = 0
        let actionSequenz = SKAction.sequence([SKAction.repeat(SKAction.move(by: CGVector(dx: 0, dy: 200), duration: 1.0), count: 4), SKAction.removeFromParent()])
        munitionSprite.run(actionSequenz)
        run(SKAction.playSoundFileNamed("raumschiff_feuer.m4a", waitForCompletion: false))
    }
}
