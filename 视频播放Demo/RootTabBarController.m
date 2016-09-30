//
//  RootTabBarController.m
//  视频播放Demo
//
//  Created by lingzhi on 16/9/28.
//  Copyright © 2016年 lingzhi. All rights reserved.
//

#import "RootTabBarController.h"
#import "TencentNewsViewController.h"
#import "SinaNewsViewController.h"
#import "NetEaseViewController.h"
#import "PersonCenterViewController.h"

#import "BaseNavigationController.h"


@interface RootTabBarController ()

@end

@implementation RootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    TencentNewsViewController *tencentVC = [[TencentNewsViewController alloc] init];
    tencentVC.title = @"腾讯";
    
    BaseNavigationController *tencentNav = [[BaseNavigationController alloc] initWithRootViewController:tencentVC];
    
    tencentNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"腾讯" image:[UIImage imageNamed:@"found"] selectedImage:[UIImage imageNamed:@"found_s"]];
    
    tencentNav.navigationBar.barTintColor = [UIColor redColor];
    
    
    
    SinaNewsViewController *sinaVC = [[SinaNewsViewController alloc] init];
    sinaVC.title = @"新浪";
    BaseNavigationController *sinaNav = [[BaseNavigationController alloc] initWithRootViewController:sinaVC];
    sinaNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"新浪" image:[UIImage imageNamed:@"message"] selectedImage:[UIImage imageNamed:@"message_s"]];
    
    
    NetEaseViewController *netEaseVC = [[NetEaseViewController alloc] init];
    netEaseVC.title = @"网易";
    BaseNavigationController *netEaseNav = [[BaseNavigationController alloc] initWithRootViewController:netEaseVC];
    netEaseNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"网易" image:[UIImage imageNamed:@"share@2x.png"] selectedImage:[UIImage imageNamed:@"share_s@2x.png"]];
    
    
    
    PersonCenterViewController *personVC = [[PersonCenterViewController alloc] init];
    personVC.title = @"我";
    BaseNavigationController *personNav = [[BaseNavigationController alloc] initWithRootViewController:personVC];
    personNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我" image:[UIImage imageNamed:@"tab_icon05"]  selectedImage:[UIImage imageNamed:@"tab_icon05_on"]];
    
    self.viewControllers = @[tencentNav,sinaNav,netEaseNav,personNav];
    
    self.tabBar.tintColor = [UIColor redColor];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
