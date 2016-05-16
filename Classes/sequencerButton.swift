//
//  sequencerButton.swift
//  TAAESample
//
//  Created by Miguel Saldana on 5/10/16.
//  Copyright © 2016 A Tasty Pixel. All rights reserved.
//

import UIKit

@IBDesignable
public class sequencerButton: UIView {

    var active = false
    var selected = false
    
    var test = ViewController()
    
    override public func drawRect(rect: CGRect) {
        PadsStyleKit.drawSeqbutton(on: active, selected: selected)
        
        
    }
    
     func refresh2() {
        
        print("refresh")
        selected = true
        self.setNeedsDisplay()
    }
    
    override public func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if(active == false){
            active = true
        }else{
            active = false
        }
        //setPercentagesWithTouchPoint()
        self.setNeedsDisplay()
        
    }
    
    override public func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        
        self.setNeedsDisplay()
    }
    
     func setPercentagesWithTouchPoint() {
        print("refresh2")
        //test.seq1.selected = true
        //test.seq1.setNeedsDisplay()
        test.startAnimation()
        //self.setNeedsDisplay()
    }
    
   
}


    


