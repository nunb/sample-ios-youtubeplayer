//
//  ViewController.m
//  SampleYouTubeVideo
//
//  Created by Makoto Kaneko on 2014/10/23.
//  Copyright (c) 2014年 quiet branch studio. All rights reserved.
//

#import "ViewController.h"
#import "SingleVideoPlayController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark -

- (IBAction)showYouTubeVideoPlayer:(id)sender
{
  [self presentViewController:
   [SingleVideoPlayController singleVideoPlayControllerWithVideoID:self.videoID
                                                        playerVars:@{
                                                                     @"rel" : @0,
                                                                     @"controls" : @0,
                                                                     @"playsinline" : @1,
                                                                     @"autoplay" : @1,
                                                                     @"autohide" : @1,
                                                                     @"showinfo" : @0,
                                                                     @"enablejsapi" : @1,
                                                                     @"modestbranding" : @1,
                                                                     }]
                     animated:YES
                   completion:nil];
}

@end
