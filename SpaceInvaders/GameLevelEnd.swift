//
//  GameLevelEnd.swift
//  SpaceInvaders
//
//  Created by Zoltán Gál on 2019. 10. 07..
//  Copyright © 2019. Zoltán Gál. All rights reserved.
//

import SpriteKit

class GameLevelEnd : SKScene {
    var punkte = 0
    let labelPunkte = SKLabelNode()
    let labelMeldung = SKLabelNode()
    
    
    init(size: CGSize, punkte: Int) {
        super.init(size: size)
        self.punkte = punkte
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.black
        
        labelMeldung.fontSize = 74
        labelMeldung.fontColor = SKColor.white
        labelMeldung.text = "GAME OVER"
        labelMeldung.position = CGPoint(x: frame.maxX / 2, y: (frame.maxY / 2) + 100)
        addChild(labelMeldung)
        
        labelPunkte.fontSize = 50
        labelPunkte.fontColor = SKColor.white
        labelPunkte.text = String(punkte) + " Punkte"
        labelPunkte.position = CGPoint(x: frame.maxX / 2, y: labelMeldung.position.y - 70)
        addChild(labelPunkte)
    }
    
    override func mouseDown(with event: NSEvent) {
        NSApplication.shared.terminate(self)
    }
}
