//
//  AppDelegate.h
//  视频播放Demo
//
//  Created by lingzhi on 16/9/28.
//  Copyright © 2016年 lingzhi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootTabBarController.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) RootTabBarController *tabBar;

@property (nonatomic,strong)NSArray *sidArray;

@property (nonatomic,strong)NSArray *videoArray;

+ (AppDelegate *)shareAppDelegate;

@end

