//
//  SynthVC+Delegates.swift
//  AnalogSynthX
//
//  Created by Matthew Fecher on 1/17/16.
//  Copyright © 2016 AudioKit. All rights reserved.
//

extension ViewController {
    
    //*****************************************************************
    // MARK: - Set Delegates
    //*****************************************************************
    
    func setDelegates() {
      
        pad12.delegate = self
        pad11.delegate = self
        pad10.delegate = self
        pad9.delegate = self
        pad8.delegate = self
        pad7.delegate = self
        pad6.delegate = self
        pad5.delegate = self
        pad4.delegate = self
        pad3.delegate = self
        pad2.delegate = self
        pad1.delegate = self
        
        
    }
}