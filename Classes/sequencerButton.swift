//
//  sequencerButton.swift
//  TAAESample
//
//  Created by Miguel Saldana on 5/10/16.
//  Copyright © 2016 A Tasty Pixel. All rights reserved.
//

import UIKit


class seqBttn: seqButton {
    var active = false
    var selected = false
    override func drawRect(rect: CGRect) {
        PadsStyleKit.drawSeqbutton(on: active, selected: selected)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if(active == false){
            active = true
        }else{
            active = false
        }
        self.setNeedsDisplay()
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        
        self.setNeedsDisplay()
    }
    
}


class seqButton:UIView{
    
}
