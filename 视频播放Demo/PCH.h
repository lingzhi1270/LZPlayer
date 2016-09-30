//
//  PCH.h
//  视频播放Demo
//
//  Created by lingzhi on 16/9/30.
//  Copyright © 2016年 lingzhi. All rights reserved.
//

#ifndef PCH_h
#define PCH_h


#import "DataManager.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+Show.h"
#import "AppDelegate.h"
#import "WMPlayer.h"
#import "BaseViewController.h"
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kDeviceVersion [[UIDevice currentDevice].systemVersion floatValue]
#define WS(weakSelf) __weak __typeof(&*self)weakSelf = self;

#define kNavbarHeight ((kDeviceVersion>=7.0)? 64 :44 )
#define kIOS7DELTA   ((kDeviceVersion>=7.0)? 20 :0 )
#define kTabBarHeight 49

#endif /* PCH_h */
