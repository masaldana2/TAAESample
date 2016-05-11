//
//  AEAudioController.m
//  TAAESample
//
//  Created by Michael Tyson on 24/03/2016.
//  Copyright © 2016 A Tasty Pixel. All rights reserved.
//
// Strictly for educational purposes only. No part of TAAESample is to be distributed
// in any form other than as source code within the TAAE2 repository.

#import "AEAudioController.h"
@import AVFoundation;
#import "sequencerController.h"


@interface AEAudioController ()
@property (nonatomic, strong) AEAudioUnitOutput * output;
@property (nonatomic,strong,readwrite) AEBandpassModule * bandpass;
@property (nonatomic,strong) AEManagedValue * recorderValue;
@property (nonatomic,strong) NSURL *recordingPath;//computed value
@property(nonatomic,strong,readwrite) AEAudioFilePlayerModule * _Nonnull drums;
@property(nonatomic,strong,readwrite) AEAudioFilePlayerModule * _Nonnull clap;
@property(nonatomic,strong,readwrite) AEAudioFilePlayerModule * _Nonnull amen;
@property(nonatomic,strong,readwrite) AEAudioFilePlayerModule * _Nonnull bass;
@property(nonatomic,strong,readwrite) AEAudioFilePlayerModule * _Nonnull cymbal;
@property(nonatomic,strong,readwrite) AEAudioFilePlayerModule * _Nonnull hat;
@property(nonatomic,strong,readwrite) AEAudioFilePlayerModule * _Nonnull loop1;
@property(nonatomic,strong,readwrite) AEAudioFilePlayerModule * _Nonnull loop2;
@property(nonatomic,strong,readwrite) AEAudioFilePlayerModule * _Nonnull rim;
@property(nonatomic,strong,readwrite) AEAudioFilePlayerModule * _Nonnull snare;
@property(nonatomic,strong,readwrite) AEAudioFilePlayerModule * _Nonnull vocal;

@property (nonatomic, readwrite) BOOL playingRecording;

@property (nonatomic, strong, readwrite) AEVarispeedModule * varispeed;



@property (nonatomic, strong) AEManagedValue * playerValue;

@end

@implementation AEAudioController
@dynamic recordingPath;
-(instancetype)init{
    if ( !(self = [super init]) ) return nil;
    
    
    AERenderer * renderer = [AERenderer new];
     AERenderer * subrenderer = [AERenderer new];

    self.output = [[AEAudioUnitOutput alloc] initWithRenderer:renderer];//get output sooner

    NSMutableArray * players = [NSMutableArray array];
    
    AEAudioFilePlayerModule * amen = [[AEAudioFilePlayerModule alloc]initWithRenderer:subrenderer URL:[[NSBundle mainBundle]URLForResource:@"rim" withExtension:@"m4a"] error:NULL];//init sample
    self.amen = amen;
    [players addObject:amen];

    
    // Setup loops
    NSURL * url = [[NSBundle mainBundle] URLForResource:@"kick15" withExtension:@"m4a"];
    AEAudioFilePlayerModule * drums = [[AEAudioFilePlayerModule alloc] initWithRenderer:subrenderer URL:url error:NULL];
    self.drums = drums;
    [players addObject:drums];
    
    url = [[NSBundle mainBundle] URLForResource:@"clap" withExtension:@"m4a"];
    AEAudioFilePlayerModule * clap = [[AEAudioFilePlayerModule alloc] initWithRenderer:renderer URL:url error:NULL];
    self.clap = clap;
    [players addObject:clap];

    
    url = [[NSBundle mainBundle] URLForResource:@"bassdrop" withExtension:@"m4a"];
    AEAudioFilePlayerModule * bass = [[AEAudioFilePlayerModule alloc] initWithRenderer:subrenderer URL:url error:NULL];
    self.bass = bass;
    [players addObject:bass];
    
    url = [[NSBundle mainBundle] URLForResource:@"cymbal" withExtension:@"m4a"];
    AEAudioFilePlayerModule * cymbal = [[AEAudioFilePlayerModule alloc] initWithRenderer:subrenderer URL:url error:NULL];
    self.cymbal = cymbal;
    [players addObject:cymbal];
    
    url = [[NSBundle mainBundle] URLForResource:@"hat" withExtension:@"m4a"];
    AEAudioFilePlayerModule * hat = [[AEAudioFilePlayerModule alloc] initWithRenderer:subrenderer URL:url error:NULL];
    self.hat = hat;
    [players addObject:hat];
    
    url = [[NSBundle mainBundle] URLForResource:@"loop55bpm" withExtension:@"m4a"];
    AEAudioFilePlayerModule * loop1 = [[AEAudioFilePlayerModule alloc] initWithRenderer:subrenderer URL:url error:NULL];
    self.loop1 = loop1;
    [players addObject:loop1];
    
    url = [[NSBundle mainBundle] URLForResource:@"loop79bpm" withExtension:@"m4a"];
    AEAudioFilePlayerModule * loop2 = [[AEAudioFilePlayerModule alloc] initWithRenderer:subrenderer URL:url error:NULL];
    self.loop2 = loop2;
    [players addObject:loop2];
    
    url = [[NSBundle mainBundle] URLForResource:@"rim" withExtension:@"m4a"];
    AEAudioFilePlayerModule * rim = [[AEAudioFilePlayerModule alloc] initWithRenderer:subrenderer URL:url error:NULL];
    self.rim = rim;
    [players addObject:rim];
    
    url = [[NSBundle mainBundle] URLForResource:@"snareLoop" withExtension:@"m4a"];
    AEAudioFilePlayerModule * snare = [[AEAudioFilePlayerModule alloc] initWithRenderer:subrenderer URL:url error:NULL];
    self.snare = snare;
    [players addObject:snare];
    
    url = [[NSBundle mainBundle] URLForResource:@"vocal" withExtension:@"m4a"];
    AEAudioFilePlayerModule * vocal = [[AEAudioFilePlayerModule alloc] initWithRenderer:subrenderer URL:url error:NULL];
    self.vocal = vocal;
    [players addObject:vocal];
    
//    url = [[NSBundle mainBundle] URLForResource:@"clap" withExtension:@"m4a"];
//    AEAudioFilePlayerModule * clap = [[AEAudioFilePlayerModule alloc] initWithRenderer:renderer URL:url error:NULL];
//    self.clap = clap;
//    [players addObject:clap];
//    
//    url = [[NSBundle mainBundle] URLForResource:@"clap" withExtension:@"m4a"];
//    AEAudioFilePlayerModule * clap = [[AEAudioFilePlayerModule alloc] initWithRenderer:renderer URL:url error:NULL];
//    self.clap = clap;
//    [players addObject:clap];
    
    //SEQUENCER thread
    [NSThread detachNewThreadSelector:@selector(aMethod:) toTarget:[sequencerController class] withObject:nil];
    
    // Create an array we can access on the render thread
    AEArray * playersArray = [AEArray new];
    [playersArray updateWithContentsOfArray:players];
    
    AEBandpassModule * bandpass = [[AEBandpassModule alloc]initWithRenderer:renderer];//init bandpass
    self.bandpass = bandpass;
    
    AEManagedValue * recorderValue = [AEManagedValue new];
    self.recorderValue = recorderValue;
    
    //AEAudioUnitInputModule * input = self.output.inputModule;//mic input
    
    AEDelayModule * delay = [[AEDelayModule alloc]initWithRenderer:renderer];
    delay.delayTime = drums.duration / 5.0; //amen loop length divided by 16
    
    AEVarispeedModule * varispeed = [[AEVarispeedModule alloc] initWithRenderer:renderer subrenderer:subrenderer];
    
    
    subrenderer.block = ^(const AERenderContext * context){//top level of audio processing

        AEArrayEnumerateObjects(playersArray, AEAudioFilePlayerModule *, player, {
            if ( AEAudioFilePlayerModuleGetPlaying(player) ) {
                AEManagedValueCommitPendingAtomicUpdates();
        
        
        AEModuleProcess(player,context);
        AEBufferStackMix(context->stack,0);
                
                
        //separate chain input mic
        AERenderContextOutput(context, 1);

        
            }
            
    };
    
    });
   
        
        // Setup recording player placeholder
        AEManagedValue * playerValue = [AEManagedValue new];
        self.playerValue = playerValue;
        
         self.varispeed = varispeed;//connects subrenderer to renderer
        
        renderer.block = ^(const AERenderContext * _Nonnull context) {
            
            //record module
            
            // Run varispeed unit, which will run its own render loop, above
            AEModuleProcess(varispeed, context);
            //AEModuleProcess(bandpass, context);
            //mix two buffers amen break with bandpass + input mix with delay = ->output
            AEBufferStackMix(context->stack,0);
            
            

            AERenderContextOutput(context, 1);
            
            __unsafe_unretained AEFileRecorderModule * recorder = (__bridge AEFileRecorderModule*)AEManagedValueGetValue(recorderValue);
            
            // See if we have an active player
            __unsafe_unretained AEAudioFilePlayerModule * player = (__bridge AEAudioFilePlayerModule*)AEManagedValueGetValue(playerValue);
            
            if(recorder){
                AEModuleProcess(recorder, context);
            }
            
            // Play recorded file, if playing
            if ( player ) {
                NSLog(@"ay cos");
                // Play
                AEModuleProcess(player, context);
                AERenderContextOutput(context, 1);
                // Put on output
                //AERenderContextOutput(context, 1);
            }
            
            
        };
        
    
    return self;
}


    - (void)dealloc {
        [self stop];
    }


-(BOOL)start:(NSError * _Nullable * _Nullable)error{
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord
                                     withOptions:AVAudioSessionCategoryOptionMixWithOthers | AVAudioSessionCategoryOptionDefaultToSpeaker
                                           error:NULL];
    return [self.output start:error];
   
}

-(void)stop{
    [self.output stop];
}

    - (void)playRecordingWithCompletionBlock:(void (^)())block {
        NSURL * url = self.recordingPath;
        if ( [[NSFileManager defaultManager] fileExistsAtPath:url.path] ) {
            
            // Start player
            AEAudioFilePlayerModule * player =
            [[AEAudioFilePlayerModule alloc] initWithRenderer:self.output.renderer URL:url error:NULL];
            if ( !player ) return;
            
            // Make player available to audio renderer
            self.playerValue.objectValue = player;
            __weak AEAudioController * weakSelf = self;
            player.completionBlock = ^{
                // Keep track of when playback ends
                [weakSelf stopPlayingRecording];
                if ( block ) block();
            };
            
            // Go
            NSLog(@"play2 %@", url);
            self.playingRecording = YES;
            [player playAtTime:0];
        }
    }
    
    - (void)stopPlayingRecording {
        self.playingRecording = NO;
        self.playerValue.objectValue = nil;
    }
    
-(void)setRecording:(BOOL)recording{
    if(_recording==recording) return;
    
    _recording = recording;
    
    if(_recording){
        AEFileRecorderModule * recorder = [[AEFileRecorderModule alloc]initWithRenderer:self.output.renderer
                                                                                    URL:self.recordingPath
                                                                                   type:AEAudioFileTypeM4A
                                                                                  error:NULL];
        [recorder beginRecordingAtTime:0];
        self.recorderValue.objectValue = recorder;//change the value and retain it
        
    }else{
        
        [(AEFileRecorderModule*)self.recorderValue.objectValue stopRecordingAtTime:0 completionBlock:^{
            self.recorderValue.objectValue = nil;
        }];
        
    }
}

    - (NSURL *)recordingPath {
        NSURL * docs = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].firstObject;
        return [docs URLByAppendingPathComponent:@"Recording5.m4a"];
    }

@end
