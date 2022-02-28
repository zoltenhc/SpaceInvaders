//
//  Alien.swift
//  SpaceInvaders
//
//  Created by Zoltán Gál on 2019. 10. 07..
//  Copyright © 2019. Zoltán Gál. All rights reserved.
//

import SpriteKit

class Alien : SKSpriteNode {
    
    var geschwindigkeit = 3
    var feuerGeschwindigkeit = 96
    
    var szene : SKScene!
    
    init(textureNummer: Int) {
        let bildName = "invader_0" + String(textureNummer)
        let bild = SKTexture(imageNamed: bildName)
        super.init(texture: bild, color: NSColor.black, size: bild.size())
        name = "alien"
        
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.categoryBitMask = 0b10
        self.physicsBody?.contactTestBitMask = 0b1000
        self.physicsBody?.collisionBitMask = 0
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setzePosition(szene : SKScene, startPos: CGPoint) {
        self.szene = szene
        position = startPos
        self.szene.addChild(self)
        position = startPos
    }
    
    func bewegen(rechtsLinks: Int, nachUnten: Int) -> Bool {
        var kontakt = false
        position = CGPoint(x: position.x + CGFloat(rechtsLinks * geschwindigkeit), y: position.y - (CGFloat(nachUnten) * size.height))
        if position.x < 50 || position.x >= szene.frame.maxX - 50 {
            kontakt = true
            if position.x <= 50 {
                position.x = 51
            }else{
                position.x = szene.frame.maxX - 51
            }
        }
        return kontakt
    }
    
    func feuern() {
        if arc4random_uniform(UInt32(feuerGeschwindigkeit)) == 0 {
            let munitionSprite = SKSpriteNode(imageNamed: "munition_invader")
            munitionSprite.position = CGPoint(x: frame.midX, y: frame.maxY)
            szene.addChild(munitionSprite)
            munitionSprite.run(SKAction.repeatForever(SKAction.move(by: CGVector(dx: 0, dy: -200), duration: 1.0)))
            munitionSprite.physicsBody = SKPhysicsBody(rectangleOf: munitionSprite.size)
           munitionSprite.physicsBody?.categoryBitMask = 0b100
            munitionSprite.physicsBody?.contactTestBitMask = 0b1
            munitionSprite.physicsBody?.collisionBitMask = 0
            let actionSequenz = SKAction.sequence([SKAction.repeat(SKAction.move(by: CGVector(dx: 0, dy: -200), duration: 1.0), count: 4), SKAction.removeFromParent()])
            munitionSprite.run(actionSequenz)
            run(SKAction.playSoundFileNamed("alien_feuer.m4a", waitForCompletion: false))
        }
    }
}
