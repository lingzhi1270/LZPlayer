//
//  AppDelegate.m
//  视频播放Demo
//
//  Created by lingzhi on 16/9/28.
//  Copyright © 2016年 lingzhi. All rights reserved.
//

#import "AppDelegate.h"
#import "DataManager.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

+ (AppDelegate *)shareAppDelegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [[DataManager shareDataManager] getSidArrayWithUrlString:@"http://c.m.163.com/nc/video/home/0-10.html" success:^(NSArray *sidArray, NSArray *videoArray) {
        
        self.sidArray = sidArray;
        self.videoArray = videoArray;
        NSLog(@"%@",self.sidArray);
        NSLog(@"%@",self.videoArray);
        
    } failed:^(id failed) {
        
    }];
    
    
    self.tabBar = [[RootTabBarController alloc] init];
    self.window.rootViewController = self.tabBar;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
