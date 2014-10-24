//
//  ModalTransitionAnimator.h
//  SampleDatePicker
//
//  Created by kaneko makoto on 2014/10/14.
//  
//

#import <Foundation/Foundation.h>

@interface ModalTransitionAnimator : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign, getter=isPresenting) BOOL presenting;

@end
