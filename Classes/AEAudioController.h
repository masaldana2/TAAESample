//
//  AEAudioController.h
//  TAAESample
//
//  Created by Michael Tyson on 24/03/2016.
//  Copyright © 2016 A Tasty Pixel. All rights reserved.
//
// Strictly for educational purposes only. No part of TAAESample is to be distributed
// in any form other than as source code within the TAAE2 repository.

@import Foundation;
#import <TheAmazingAudioEngine/TheAmazingAudioEngine.h>

@interface AEAudioController : NSObject
-(BOOL)start:(NSError * _Nullable * _Nullable)error;
-(void)stop;

- (void)playRecordingWithCompletionBlock:(void(^ _Nullable)())block;

- (void)stopPlayingRecording;

@property(nonatomic,strong, readonly) AEBandpassModule * _Nonnull bandpass;
@property(nonatomic,)BOOL recording;
@property(nonatomic,strong,readonly) AEAudioFilePlayerModule * _Nonnull drums;
@property(nonatomic,strong,readonly) AEAudioFilePlayerModule * _Nonnull clap;
@property(nonatomic,strong,readonly) AEAudioFilePlayerModule * _Nonnull amen;

@property(nonatomic,strong,readonly) AEAudioFilePlayerModule * _Nonnull bass;
@property(nonatomic,strong,readonly) AEAudioFilePlayerModule * _Nonnull cymbal;
@property(nonatomic,strong,readonly) AEAudioFilePlayerModule * _Nonnull hat;
@property(nonatomic,strong,readonly) AEAudioFilePlayerModule * _Nonnull loop1;
@property(nonatomic,strong,readonly) AEAudioFilePlayerModule * _Nonnull loop2;
@property(nonatomic,strong,readonly) AEAudioFilePlayerModule * _Nonnull rim;
@property(nonatomic,strong,readonly) AEAudioFilePlayerModule * _Nonnull snare;
@property(nonatomic,strong,readonly) AEAudioFilePlayerModule * _Nonnull vocal;
@property (nonatomic, strong, readonly) AEVarispeedModule * _Nonnull varispeed;
@property (nonatomic, strong, readonly) AEVarispeedModule * _Nonnull conector2;


@property (nonatomic, readonly) BOOL playingRecording;


@end


