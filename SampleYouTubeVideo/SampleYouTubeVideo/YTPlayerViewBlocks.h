//
//  YTPlayerViewBlocks.h
//  SampleYouTubeVideo
//
//  Created by Yappa iosdev on 2014/10/24.
//  Copyright (c) 2014年 quiet branch studio. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <YTPlayerView.h>

// YTPlayerViewDelegate Block typedefs

typedef void (^PlayerViewDidBecomeReadyBlock)(YTPlayerView *playerView);
typedef void (^PlayerViewDidChangeToStateBlock)(YTPlayerView *playerView, YTPlayerState state);
typedef void (^PlayerViewDidChangeToQualityBlock)(YTPlayerView *playerView, YTPlaybackQuality quality);
typedef void (^PlayerViewReceivedErrorBlock)(YTPlayerView *playerView, YTPlayerError error);

@interface YTPlayerViewBlocks : NSObject

+ (instancetype)ytPlayerViewBlocksWithView:(YTPlayerView *)playerView;

#pragma mark - YTPlayerViewDelegate Block setter definitions

- (instancetype)setPlayerViewDidBecomeReadyBlock:(PlayerViewDidBecomeReadyBlock)block;
- (instancetype)setPlayerViewDidChangeToStateBlock:(PlayerViewDidChangeToStateBlock)block;
- (instancetype)setPlayerViewDidChangeToQualityBlock:(PlayerViewDidChangeToQualityBlock)block;
- (instancetype)setPlayerViewReceivedErrorBlock:(PlayerViewReceivedErrorBlock)block;

@end
