//
//  KnobMedium.swift
//  Swift Synth
//
//  Created by Matthew Fecher on 1/18/16.
//  Copyright © 2016 AudioKit. All rights reserved.
//

import UIKit

protocol PadPushDelegate {
    func playPad(tag: Int)
}




class PadMedium: pad {
    var isPressed = false
    var delegate: PadPushDelegate?
    
    override func drawRect(rect: CGRect) {
        PadsStyleKit.drawCanvas1(isPressed: isPressed)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //play.snarePlay()
        self.isPressed = true
        delegate?.playPad(self.tag)
        self.setNeedsDisplay()
      
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.isPressed = false
        self.setNeedsDisplay()
    }
    
}


class pad:UIView{
    
}
