//
//  sequencerController.m
//  TAAESample
//
//  Created by Miguel Saldana on 5/11/16.
//  Copyright © 2016 A Tasty Pixel. All rights reserved.
//

#import "sequencerController.h"
#import <Foundation/Foundation.h>
@implementation sequencerController

#define STEPS_PER_BAR 16
#define bpm 60


+(void)aMethod:(id)param{
    BOOL isRunning = true;
    int currentStep = 0;
    float nextStepStartTime = 0;
    while(isRunning)
    {
        
        // prepare for step
        currentStep++;
        if(currentStep >= STEPS_PER_BAR )
            currentStep = 0;
        
        
        //calculate the time to sleep until the next step
        NSTimeInterval stepDuration = (60.0f / (float)bpm) / (STEPS_PER_BAR / 4);
        nextStepStartTime = nextStepStartTime + stepDuration;
        NSTimeInterval now = [NSDate timeIntervalSinceReferenceDate];
        [NSThread sleepForTimeInterval:stepDuration];
        NSLog (@"hello world %i at speed %f",currentStep , stepDuration);
        
        // sleep if there is time left
        if(nextStepStartTime > now)
            [NSThread sleepForTimeInterval:0.125];
        else {
            //NSLog(@"WARNING: sequencer loop is lagging behind");
        }
      
        
     
    }
    
}
@end

