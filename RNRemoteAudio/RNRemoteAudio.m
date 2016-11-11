//
//  RNRemoteAudio.m
//  ReactNativeRemoteAudio
//
//  Created by Johan West on 2016-11-10.
//

#import "RNRemoteAudio.h"

static NSString *const PlaybackDidFinish = @"PlaybackDidFinish";
static NSString *const PlaybackReady = @"PlaybackReady";

@implementation RNRemoteAudio

RCT_EXPORT_MODULE()

- (NSArray<NSString *> *)supportedEvents
{
  return @[PlaybackDidFinish, PlaybackReady];
}

- (NSDictionary *)constantsToExport
{
  return @{PlaybackDidFinish: PlaybackDidFinish, PlaybackReady: PlaybackReady};
}

RCT_EXPORT_METHOD(play:(NSString *)songUrl)
{
  NSURL *url = [[NSURL alloc] initWithString:songUrl];
  AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:url];

  [self initPlayerWithItem:item];
  [self.player play];

  [self.player addObserver:self forKeyPath:@"status" options:0 context:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(didFinishPlayback)
                                               name:AVPlayerItemDidPlayToEndTimeNotification
                                             object:nil];
}

RCT_EXPORT_METHOD(pause)
{
  [self resetPlayer];
}

- (void)didFinishPlayback
{
  [self resetPlayer];
  [self sendEventWithName:PlaybackDidFinish body:nil];
}

- (void)initPlayerWithItem:(AVPlayerItem *)item
{
  [self resetPlayer];
  self.player = [[AVPlayer alloc] initWithPlayerItem:item];
}

- (void)resetPlayer
{
  if (self.player) {
    [self.player removeObserver:self forKeyPath:@"status"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    [self.player pause];
    self.player = nil;
  }
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context
{
  if (object == self.player && [keyPath isEqualToString:@"status"]) {
    if (self.player.status == AVPlayerStatusReadyToPlay) {
      [self sendEventWithName:PlaybackReady body:nil];
    }

    // TODO Listen for errors
  }
}

@end
