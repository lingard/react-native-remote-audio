//
//  RNRemoteAudio.h
//  ReactNativeRemoteAudio
//
//  Created by Johan West on 2016-11-10.
//

#import <AVFoundation/AVFoundation.h>
#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>

@interface RNRemoteAudio : RCTEventEmitter <RCTBridgeModule>

@property (nonatomic) AVPlayer *player;

- (void)didFinishPlayback;
- (void)initPlayerWithItem:(AVPlayerItem *)item;
- (void)resetPlayer;

@end
