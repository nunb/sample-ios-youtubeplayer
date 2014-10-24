//
//  YTPlayerViewBlocks.m
//  SampleYouTubeVideo
//
//  Created by Yappa iosdev on 2014/10/24.
//  Copyright (c) 2014年 quiet branch studio. All rights reserved.
//

#import "YTPlayerViewBlocks.h"

#import <objc/runtime.h>

@interface YTPlayerViewBlocks () <YTPlayerViewDelegate>
@end

@implementation YTPlayerViewBlocks

static char YTPlayerViewBlocksKey;

// YTPlayerViewDelegate Block keys

static char PlayerViewDidBecomeReadyKey;
static char PlayerViewDidChangeToStateKey;
static char PlayerViewDidChangeToQualityKey;
static char PlayerViewReceivedErrorKey;

+ (instancetype)ytPlayerViewBlocksWithView:(YTPlayerView *)playerView {
  return ^(YTPlayerViewBlocks *blocks) {
    playerView.delegate = blocks;
    objc_setAssociatedObject(playerView, &YTPlayerViewBlocksKey, blocks, OBJC_ASSOCIATION_RETAIN);
    return blocks;
  } ([[YTPlayerViewBlocks alloc] init]);
}

#pragma mark - YTPlayerViewDelegate Block setters

- (instancetype)setPlayerViewDidBecomeReadyBlock:(PlayerViewDidBecomeReadyBlock)block
{
  objc_setAssociatedObject(self, &PlayerViewDidBecomeReadyKey, block, OBJC_ASSOCIATION_COPY);
  return self;
}

- (instancetype)setPlayerViewDidChangeToStateBlock:(PlayerViewDidChangeToStateBlock)block
{
  objc_setAssociatedObject(self, &PlayerViewDidChangeToStateKey, block, OBJC_ASSOCIATION_COPY);
  return self;
}

- (instancetype)setPlayerViewDidChangeToQualityBlock:(PlayerViewDidChangeToQualityBlock)block
{
  objc_setAssociatedObject(self, &PlayerViewDidChangeToQualityKey, block, OBJC_ASSOCIATION_COPY);
  return self;
}

- (instancetype)setPlayerViewReceivedErrorBlock:(PlayerViewReceivedErrorBlock)block
{
  objc_setAssociatedObject(self, &PlayerViewReceivedErrorKey, block, OBJC_ASSOCIATION_COPY);
  return self;
}

#pragma mark - YTPlayerViewDelegate

- (void) playerViewDidBecomeReady:(YTPlayerView *)playerView
{
  ^(PlayerViewDidBecomeReadyBlock block) {
    if (block)
      block(playerView);
  } (objc_getAssociatedObject(self, &PlayerViewDidBecomeReadyKey));
}

- (void) playerView:(YTPlayerView *)playerView didChangeToState:(YTPlayerState)state
{
  ^(PlayerViewDidChangeToStateBlock block) {
    if (block)
      block(playerView, state);
  } (objc_getAssociatedObject(self, &PlayerViewDidChangeToStateKey));
}

- (void) playerView:(YTPlayerView *)playerView didChangeToQuality:(YTPlaybackQuality)quality
{
  ^(PlayerViewDidChangeToQualityBlock block) {
    if (block)
      block(playerView, quality);
  } (objc_getAssociatedObject(self, &PlayerViewDidChangeToQualityKey));
}

- (void) playerView:(YTPlayerView *)playerView receivedError:(YTPlayerError)error
{
  ^(PlayerViewReceivedErrorBlock block) {
    if (block)
      block(playerView, error);
  } (objc_getAssociatedObject(self, &PlayerViewReceivedErrorKey));
}

@end
