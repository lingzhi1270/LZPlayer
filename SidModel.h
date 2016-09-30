//
//  SidModel.h
//  视频播放Demo
//
//  Created by lingzhi on 16/9/29.
//  Copyright © 2016年 lingzhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SidModel : NSObject
@property (nonatomic, strong) NSString * imgsrc;
@property (nonatomic, strong) NSString * sid;
@property (nonatomic, strong) NSString * title;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

+ (instancetype)modelWithDictionary:(NSDictionary *)dic;
@end
