//
//  SKButton.swift
//  SKStudy
//
//  Created by Robin Peng on 8/31/16.
//  Copyright © 2016 Robin. All rights reserved.
//

import Foundation
import SpriteKit

class SKButton : SKNode {

    var defaultButton: SKSpriteNode
    var activeButton: SKSpriteNode
    var action: (_ : SKButton) -> Void
    
    private var activeTouch: UITouch?
    
    init(defaultImage: String, activeImage: String, buttonAction: @escaping (_ : SKButton)->Void) {
        defaultButton = SKSpriteNode(imageNamed: defaultImage)
        activeButton = SKSpriteNode(imageNamed: activeImage)
        activeButton.isHidden = true
        action = buttonAction
        
        super.init()
        
        self.isUserInteractionEnabled = true
        self.addChild(defaultButton)
        self.addChild(activeButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.count == 1 {
            self.activeTouch = touches[touches.startIndex]
            
            activeButton.isHidden = false
            defaultButton.isHidden = true
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = self.activeTouch {
            let location: CGPoint = touch.location(in: self)
            
            if self.defaultButton.contains(location) {
                self.activeButton.isHidden = false
                self.defaultButton.isHidden = true
            }
            else {
                self.activeButton.isHidden = true
                self.defaultButton.isHidden = false
            }
            
            
            
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = self.activeTouch {
            let location: CGPoint = touch.location(in: self)
            
            if self.defaultButton.contains(location) {
                self.action(self)
            }
            
            self.activeButton.isHidden = true
            self.defaultButton.isHidden = false
            self.activeTouch = nil
        }
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.activeTouch != nil {
            self.activeButton.isHidden = true
            self.defaultButton.isHidden = false
            self.activeTouch = nil
        }
    }

}
