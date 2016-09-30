//
//  BaseViewController.h
//  视频播放Demo
//
//  Created by lingzhi on 16/9/28.
//  Copyright © 2016年 lingzhi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MBProgressHUD;
@interface BaseViewController : UIViewController

@property (nonatomic,strong)MBProgressHUD *hud;
- (void)addHud;
- (void)addHudWithMessage:(NSString *)message;
- (void)removeHud;

@end
