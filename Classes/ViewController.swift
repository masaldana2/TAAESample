//
//  ViewController.swift
//  TAED TEST DEMO
//
//  Created by Miguel Saldana on 4/28/16.
//  Copyright © 2016 Miguel Saldana. All rights reserved.
//

import UIKit

enum ControlTag: Int {
    
    case DelayTime = 120
    case DelayMix = 119
    case pad12 = 12
    case pad11 = 11
    case pad10 = 10
    case pad9 = 9
    case pad8 = 8
    case pad7 = 7
    case pad6 = 6
    case pad5 = 5
    case pad4 = 4
    case pad3 = 3
    case pad2 = 2
    case pad1 = 1
    
}
class ViewController: UIViewController {
        var audio: AEAudioController?
    @IBOutlet var pad12: PadMedium!
    @IBOutlet var pad11: PadMedium!
    @IBOutlet var pad10: PadMedium!
    @IBOutlet var pad9: PadMedium!
    @IBOutlet var pad8: PadMedium!
    @IBOutlet var pad7: PadMedium!
    @IBOutlet var pad6: PadMedium!
    @IBOutlet var pad5: PadMedium!
    @IBOutlet var pad4: PadMedium!
    @IBOutlet var pad3: PadMedium!
    @IBOutlet var pad2: PadMedium!
    @IBOutlet var pad1: PadMedium!
    
    @IBOutlet var seq1: sequencerButton!
    
    @IBOutlet var playButton: UIButton!
    @IBOutlet var value: UILabel!
    //HIDE STATUS BAR
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Set Delegates
        setDelegates()
        //startAnimation()
        
        dispatch_async(dispatch_get_main_queue()) {
            self.startAnimation()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func bandpassSlider(sender: UISlider) {
        let x = Double(sender.value)
        let value1:Double
        audio?.bandpass.centerFrequency = max(0.1, x*x*x*x*16000.0);
        value1 = max(0.1, x*x*x*x*16000.0)
        value.text = "\(value1)"
        print(value1)
    }
    @IBAction func toggleRecording(sender: UIButton) {
        if let audioController = audio{
            audioController.recording = !audioController.recording;
            sender.selected = audioController.recording;
        }
    }
    
    @IBAction func playTap(sender: UIButton) {
        if let audio = audio {
            if audio.playingRecording {
                // Stop the playback
                print("stap")
                audio.stopPlayingRecording()
                self.playButton.selected = false
            } else {
                // Start playback
                self.playButton.selected = true
                print("play")
                audio.playRecordingWithCompletionBlock({
                    self.playButton.selected = false
                    
                })
            }
        }
        
    }
    
    func startAnimation() {
        seq1.selected = true
        seq1.setNeedsDisplay()
        
        
    }
    

}



extension ViewController: PadPushDelegate {
    
    func playPad(tag: Int) {
        
        switch (tag) {
            
        case ControlTag.pad12.rawValue:
            print(tag)
        case ControlTag.pad11.rawValue:
            if((audio?.loop2.playing) != false){
                audio?.loop2.currentTime = 0
                audio?.loop2.playAtTime(0)
                
            }else{
                audio?.loop2.playAtTime(0)
                
            }
        case ControlTag.pad10.rawValue:
            if((audio?.loop1.playing) != false){
                audio?.loop1.currentTime = 0
                audio?.loop1.playAtTime(0)
                
            }else{
                audio?.loop1.playAtTime(0)
                
            }
        case ControlTag.pad9.rawValue:
            if((audio?.vocal.playing) != false){
                audio?.vocal.currentTime = 0
                audio?.vocal.playAtTime(0)
                
            }else{
                audio?.vocal.playAtTime(0)
                
            }
        case ControlTag.pad8.rawValue:
            if((audio?.cymbal.playing) != false){
                audio?.cymbal.currentTime = 0
                audio?.cymbal.playAtTime(0)
                
            }else{
                audio?.cymbal.playAtTime(0)
                
            }
        case ControlTag.pad7.rawValue:
            
            print(tag)
        case ControlTag.pad6.rawValue:
            if((audio?.snare.playing) != false){
                audio?.snare.currentTime = 0
                audio?.snare.playAtTime(0)
                
            }else{
                audio?.snare.playAtTime(0)
                
            }
           
        case ControlTag.pad5.rawValue:
            if((audio?.hat.playing) != false){
                audio?.hat.currentTime = 0
                audio?.hat.playAtTime(0)
                
            }else{
                audio?.hat.playAtTime(0)
                
            }
        case ControlTag.pad4.rawValue:
            if((audio?.clap.playing) != false){
                audio?.clap.currentTime = 0
                audio?.clap.playAtTime(0)
                
            }else{
                audio?.clap.playAtTime(0)
                
            }
        case ControlTag.pad3.rawValue:
            if((audio?.rim.playing) != false){
                audio?.rim.currentTime = 0
                audio?.rim.playAtTime(0)
                
            }else{
                audio?.rim.playAtTime(0)
                
            }

        case ControlTag.pad2.rawValue:
            if((audio?.bass.playing) != false){
                audio?.bass.currentTime = 0
                audio?.bass.playAtTime(0)
                
            }else{
                audio?.bass.playAtTime(0)
                
            }
        case ControlTag.pad1.rawValue:
            if((audio?.drums.playing) != false){
                audio?.drums.currentTime = 0
                audio?.drums.playAtTime(0)
            }else{
                audio?.drums.playAtTime(0)
                
            }
            
        default:
            break
        }
        
    }
    
}

