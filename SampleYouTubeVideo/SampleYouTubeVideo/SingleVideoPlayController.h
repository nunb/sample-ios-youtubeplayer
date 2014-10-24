//
//  SingleVideoPlayController.h
//  SampleYouTubeVideo
//
//  Created by Yappa iosdev on 2014/10/24.
//  Copyright (c) 2014年 quiet branch studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YTPlayerView.h>

@interface SingleVideoPlayController : UIViewController

+ (instancetype)singleVideoPlayControllerWithVideoID:(NSString *)videoID playerVars:(NSDictionary *)playerVars;

@end
