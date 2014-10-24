//
//  SingleVideoPlayController.m
//  SampleYouTubeVideo
//
//  Created by Yappa iosdev on 2014/10/24.
//  Copyright (c) 2014年 quiet branch studio. All rights reserved.
//

#import "SingleVideoPlayController.h"

#import "ModalTransitionAnimator.h"

#import "YTPlayerViewBlocks.h"

@interface SingleVideoPlayController () <UIViewControllerTransitioningDelegate>

@property (copy, nonatomic) NSString *videoID;
@property (strong, nonatomic) NSDictionary *playerVars;

@property (weak, nonatomic) IBOutlet YTPlayerView *playerView;

@end

@implementation SingleVideoPlayController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = ^(SingleVideoPlayController *me) {
    me.modalPresentationStyle = UIModalPresentationCustom;
    me.transitioningDelegate = me;
    return me;
  } ([super initWithNibName:@"SingleVideoPlayController" bundle:nil]);
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self associateWithView:self.playerView];
  [self.playerView loadWithVideoId:self.videoID
                        playerVars:self.playerVars];
  [self.playerView playVideo];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

#pragma mark -

- (instancetype)initWithVideoID:(NSString *)videoID playerVars:(NSDictionary *)playerVars
{
  self = ^(SingleVideoPlayController *me) {
    me.videoID = videoID;
    me.playerVars = playerVars;
    return me;
  } ([self initWithNibName:nil bundle:nil]);
  return self;
}

+ (instancetype)singleVideoPlayControllerWithVideoID:(NSString *)videoID playerVars:(NSDictionary *)playerVars
{
  return [[SingleVideoPlayController alloc] initWithVideoID:videoID playerVars:playerVars];
}

#pragma mark -

- (void)associateWithView:(YTPlayerView *)playerView
{
  __weak __typeof(self)blockSelf = self;
  [[YTPlayerViewBlocks ytPlayerViewBlocksWithView:playerView]
   setPlayerViewDidChangeToStateBlock:^(YTPlayerView *playerView, YTPlayerState state) {
     LOG2(@"setPlayerViewDidChangeToStateBlock state:%d", state);
     ((state == kYTPlayerStateUnstarted) ? ^{
     } : (state == kYTPlayerStateEnded) ? ^{
       [blockSelf dismissViewControllerAnimated:YES completion:nil];
     } : (state == kYTPlayerStatePlaying) ? ^{
       
     } : (state == kYTPlayerStatePaused) ? ^{
       
     } : (state == kYTPlayerStateBuffering) ? ^{
       
     } : (state == kYTPlayerStateQueued) ? ^{
       
     } : (state == kYTPlayerStateUnknown) ? ^{
       
     } : ^{
       
     })();
   }];
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
  LOG_TRACE();
  return ^(ModalTransitionAnimator *animator) {
    animator.presenting = YES;
    return animator;
  } ([ModalTransitionAnimator new]);
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
  LOG_TRACE();
  return ^(ModalTransitionAnimator *animator) {
    animator.presenting = NO;
    return animator;
  } ([ModalTransitionAnimator new]);
}

@end
