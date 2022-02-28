//
//  GameLevel1.swift
//  SpaceInvaders
//
//  Created by Zoltán Gál on 2019. 10. 07..
//  Copyright © 2019. Zoltán Gál. All rights reserved.
//

import SpriteKit

class GameLevel1: SKScene, SKPhysicsContactDelegate {
    var punkte = 0
    let labelPunkte = SKLabelNode()
    
    var energie = 100
    let labelEnergie = SKLabelNode()
    
    var meinRaumschiff = Raumschiff()
    var endAlien = EndGegner()
    
    var rechtsLinks = -1
    var linksRechts = 1
    var nachUnten = 0
    var unten = 0
    
    var letzterAufruf : TimeInterval = 0
    var zwischenZeit : TimeInterval = 0
    
    
    override func didMove(to view: SKView) {
        labelPunkte.fontSize = 24
        labelPunkte.fontColor = SKColor.white
        labelPunkte.position = CGPoint(x: frame.maxX - 50, y: frame.maxY - 50)
        labelPunkte.text = String(punkte)
        addChild(labelPunkte)
        
        labelEnergie.fontSize = 24
        labelEnergie.fontColor = SKColor.white
        labelEnergie.position = CGPoint(x: CGFloat(50), y: frame.maxY - 50)
        labelEnergie.text = String(energie)
        addChild(labelEnergie)
        
        meinRaumschiff.setzePosition(szene: self)
        endAlien.setzePosition(szene: self)
        
        var zeile = 1
        var spalte = 1
        
        for _ in 0 ..< 42 {
            let meinAlien = Alien(textureNummer: zeile)
            meinAlien.setzePosition(szene: self, startPos: CGPoint(x: CGFloat(150 + (spalte * 50)), y: CGFloat(450 + (zeile * 50))))
            spalte = spalte + 1
            if spalte == 15 {
                zeile = zeile + 1
                spalte = 1
            }
        }
        
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
    }
    
    override func keyDown(with event: NSEvent) {
        switch event.keyCode {
        case 123:
            meinRaumschiff.bewegen(rictung: -1)
        case 124:
            meinRaumschiff.bewegen(rictung: 1)
        case 49:
            if childNode(withName: "raumschiffGeschoss") == nil {
            meinRaumschiff.feuern()
            }
        default:
            print(event.keyCode)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        let delta : TimeInterval = currentTime - letzterAufruf
        var richtungsWechsel = false
        zwischenZeit = zwischenZeit + delta
        if zwischenZeit >= 1.0 {
        enumerateChildNodes(withName: "alien") {
            knoten, stop in
            if let meinAlien = knoten as? Alien {
                richtungsWechsel = meinAlien.bewegen(rechtsLinks: self.rechtsLinks, nachUnten: 0)
                if richtungsWechsel == true {
                    self.nachUnten = 1
                    stop.pointee = true
                }
                meinAlien.feuern()
                
            }
            }
            enumerateChildNodes(withName: "endgegner") {
            knoten, stop in
            if let meinGegner = knoten as? EndGegner {
                richtungsWechsel = meinGegner.bewegen(linksRechts: self.linksRechts, nachUnten: 0)
                if richtungsWechsel == true {
                    self.nachUnten = 1
                    stop.pointee = true
                }
                meinGegner.feuern()
                }
            }
            
        
        if self.nachUnten == 1 {
            enumerateChildNodes(withName: "alien") {
                knoten, stop in
                if let meinAlien = knoten as? Alien {
                    richtungsWechsel = meinAlien.bewegen(rechtsLinks: 0, nachUnten: 1)
                    //wenn sich die Aliens nach unten bewegen, erhöhen wir ihre
                    //geschwindigkeit und verringern wir die Eigenschaft
                    //"feuerGeschwindigkeit", damit unsere Aliens haufiger schiessen
                    meinAlien.geschwindigkeit = meinAlien.geschwindigkeit + 5
                    //Wir dürfen keine negative Zahlen zur Eigenschaft
                    //"feuergeschwindigkeit" zuweisen
                    //wenn die Eigenschat Feuergeschwindigkeit "0" erreicht hat,
                    //verringern wir ihre Wert nicht mehr
                    if meinAlien.feuerGeschwindigkeit != 0 {
                        meinAlien.feuerGeschwindigkeit = meinAlien.feuerGeschwindigkeit - 8
                        
                    }
                }
            }
            enumerateChildNodes(withName: "endgegner") {
            knoten, stop in
            if let meinGegner = knoten as? EndGegner {
                richtungsWechsel = meinGegner.bewegen(linksRechts: self.linksRechts, nachUnten: 1)
                meinGegner.geschwindigkeit = meinGegner.geschwindigkeit + 15
                if meinGegner.feuerGeschwindigkeit != 0 {
                    meinGegner.feuerGeschwindigkeit = meinGegner.feuerGeschwindigkeit - 1
                }
                }
            }
            
            self.nachUnten = 0
            self.rechtsLinks = self.rechtsLinks * -1
            self.linksRechts = self.linksRechts * -1
            
            
        }
            
       /* if zwischenZeit >= 1.0 {
                enumerateChildNodes(withName: "endgegner") {
                    knoten, stop in
                    if let meinGegner = knoten as? EndGegner {
                        richtungsWechsel = meinGegner.bewegen(linksRechts: self.linksRechts, nachUnten: 0)
                        if richtungsWechsel == true {
                            self.nachUnten = 1
                            stop.pointee = true
                        }
                        meinGegner.feuern()
                        
                    }
                    
                }*/
        /*if self.nachUnten == 1 {
                    enumerateChildNodes(withName: "endgegner") {
                    knoten, stop in
                    if let meinGegner = knoten as? EndGegner {
                        richtungsWechsel = meinGegner.bewegen(linksRechts: self.linksRechts, nachUnten: 1)
                        meinGegner.geschwindigkeit = meinGegner.geschwindigkeit + 10
                        if meinGegner.feuerGeschwindigkeit != 0 {
                            meinGegner.feuerGeschwindigkeit = meinGegner.feuerGeschwindigkeit - 1
                        }
                        print(meinGegner.geschwindigkeit, meinGegner.feuerGeschwindigkeit)
                        }
                    }
                    self.nachUnten = 0
                     self.linksRechts = self.linksRechts * -1
            } */
            
            
            self.zwischenZeit = 0
            }
        letzterAufruf = currentTime
    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask == 0b1010 {
            contact.bodyA.node?.removeFromParent()
            contact.bodyB.node?.removeFromParent()
            punkte = punkte + 10
            labelPunkte.text = String(punkte)
            run(SKAction.playSoundFileNamed("alien_explosion.m4a", waitForCompletion: false))
        }
        
        if contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask == 0b101 {
            contact.bodyB.node?.removeFromParent()
            energie = energie - 10
            labelEnergie.text = String(energie)
            run(SKAction.playSoundFileNamed("raumschiff_explosion.m4a", waitForCompletion: false))
        }
        if contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask == 0b11 {
            contact.bodyA.node?.removeFromParent()
            contact.bodyB.node?.removeFromParent()
            energie = 0
            labelEnergie.text = String(energie)
            run(SKAction.playSoundFileNamed("raumschiff_explosion.m4a", waitForCompletion: false))
        }
        
        istSpielZuEnde()
    }
    
    func istSpielZuEnde() {
        if energie == 0 || childNode(withName: "alien") == nil && childNode(withName: "endgegner") == nil {
            self.view?.presentScene(GameLevelEnd(size: self.size, punkte: self.punkte), transition: SKTransition.flipHorizontal(withDuration: 1.0))
        }
    }
}
