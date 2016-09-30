//
//  DataManager.h
//  视频播放Demo
//
//  Created by lingzhi on 16/9/29.
//  Copyright © 2016年 lingzhi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SuccessBlock)(NSArray *sidArray, NSArray *videoArray);
typedef void(^FailedBlock)(id failed);


@interface DataManager : NSObject

@property (nonatomic,strong)NSArray *sidArray;

@property (nonatomic,strong)NSArray *videoArray;


+ (DataManager *)shareDataManager;

- (void)getSidArrayWithUrlString:(NSString *)urlString success:(SuccessBlock)success failed:(FailedBlock)failed;

- (void)getVideoListWithUrlString:(NSString *)urlString success:(SuccessBlock)success failed:(FailedBlock)failed;


@end
