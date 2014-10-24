//
//  ModalTransitionAnimator.m
//  SampleDatePicker
//
//  Created by kaneko makoto on 2014/10/14.
//  
//

#import "ModalTransitionAnimator.h"

@implementation ModalTransitionAnimator

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
  return 0.25f;
}

- (CGRect)viewRect
{
  return ^(CGRect rect) {
    return CGRectMake(0, 0, rect.size.width, rect.size.height);
  } ([[UIScreen mainScreen] bounds]);
}

- (CGPoint)startOrigin
{
  return (([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0) ? ^{
    return ^(NSInteger orientation) {
      return ((orientation == UIDeviceOrientationLandscapeLeft) ? ^{
        return CGPointMake(-UIScreen.mainScreen.bounds.size.width, 0);
      } : (orientation == UIDeviceOrientationLandscapeRight) ? ^{
        return CGPointMake(UIScreen.mainScreen.bounds.size.width, 0);
      } : ^{
        return CGPointMake(0, UIScreen.mainScreen.bounds.size.height);
      })();
    } ([[UIDevice currentDevice] orientation]);
  } : ^{
    return CGPointMake(0, UIScreen.mainScreen.bounds.size.height);
  })();
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
  UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
  UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
  
  CGRect endFrame = [self viewRect];
  //UIView *coverView = [[UIView alloc] initWithFrame:endFrame];
  
  if (self.presenting) {
    fromViewController.view.userInteractionEnabled = NO;
    
    [transitionContext.containerView addSubview:fromViewController.view];
    //[transitionContext.containerView addSubview:coverView];
    [transitionContext.containerView addSubview:toViewController.view];
    
    CGRect startFrame = endFrame;
    startFrame.origin = [self startOrigin];

    //[coverView setBackgroundColor:[UIColor clearColor]];
    [toViewController.view setBackgroundColor:[UIColor clearColor]];
    toViewController.view.frame = startFrame;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
      fromViewController.view.tintAdjustmentMode = UIViewTintAdjustmentModeDimmed;
      //[coverView setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.375]];
      [toViewController.view setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.375]];
      toViewController.view.frame = endFrame;
    } completion:^(BOOL finished) {
      [transitionContext completeTransition:YES];
    }];
  } else {
    toViewController.view.userInteractionEnabled = YES;
    
    //[transitionContext.containerView addSubview:toViewController.view];
    //[transitionContext.containerView addSubview:coverView];
    //[transitionContext.containerView addSubview:fromViewController.view];
    
    endFrame.origin = [self startOrigin];

    //[coverView setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.375]];
    //[fromViewController.view setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.375]];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
      toViewController.view.tintAdjustmentMode = UIViewTintAdjustmentModeAutomatic;
      //[coverView setBackgroundColor:[UIColor clearColor]];
      //[fromViewController.view setBackgroundColor:[UIColor clearColor]];
      fromViewController.view.frame = endFrame;
    } completion:^(BOOL finished) {
      [fromViewController.view removeFromSuperview];
      /**
       ios8 bug? patch
       work on both ios7 and ios8
       **/
      if (![[UIApplication sharedApplication].keyWindow.subviews containsObject:toViewController.view]) {
        if (toViewController.view.superview)
          [toViewController.view removeFromSuperview];
        [[[UIApplication sharedApplication] keyWindow] addSubview:toViewController.view];
      }
      /**/
      [transitionContext completeTransition:YES];
    }];
  }
}

@end
