//
//  RNRemoteAudio.h
//  ReactNativeRemoteAudio
//
//  Created by Johan West on 2016-11-10.
//  Copyright © 2016 Facebook. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "RCTBridgeModule.h"
#import "RCTEventEmitter.h"

@interface RNRemoteAudio : RCTEventEmitter <RCTBridgeModule>

@property (nonatomic) AVPlayer *player;

- (void)didFinishPlayback;
- (void)initPlayerWithItem:(AVPlayerItem *)item;
- (void)resetPlayer;

@end
