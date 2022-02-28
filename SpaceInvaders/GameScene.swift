//
//  GameScene.swift
//  SpaceInvaders
//
//  Created by Zoltán Gál on 2019. 10. 07..
//  Copyright © 2019. Zoltán Gál. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    override func didMove(to view: SKView) {
    }
    
    override func mouseDown(with event: NSEvent) {
        self.view?.presentScene(GameLevel1(size: self.size),transition: SKTransition.flipHorizontal(withDuration: 1.0))
    }
    
    override func keyDown(with event: NSEvent) {
        self.view?.presentScene(GameLevel1(size: self.size),transition: SKTransition.flipHorizontal(withDuration: 1.0))
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
