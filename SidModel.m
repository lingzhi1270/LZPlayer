//
//  SidModel.m
//  视频播放Demo
//
//  Created by lingzhi on 16/9/29.
//  Copyright © 2016年 lingzhi. All rights reserved.
//

#import "SidModel.h"

@implementation SidModel

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        
        
        //KVC
        [self setValuesForKeysWithDictionary:dic];
        
    }
    return self;
}

+ (instancetype)modelWithDictionary:(NSDictionary *)dic
{
    return [[[SidModel class] alloc] initWithDictionary:dic];
}


@end
