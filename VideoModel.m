//
//  VideoModel.m
//  视频播放Demo
//
//  Created by lingzhi on 16/9/29.
//  Copyright © 2016年 lingzhi. All rights reserved.
//

#import "VideoModel.h"

@implementation VideoModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"description"]) {
        self.descriptionDe = value;
    }
    
}

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        
      self.cover = [dic objectForKey:@"cover"];
     self.descriptionDe = [dic objectForKey:@"description"];
      self.length = [[dic objectForKey:@"length"] integerValue];
       self.m3u8Hd_url = [dic objectForKey:@"m3u8Hd_url"];
        self.m3u8_url = [dic objectForKey:@"m3u8_url"];
        self.mp4Hd_url = [dic objectForKey:@"mp4Hd_url"];
       self.mp4_url = [dic objectForKey:@"mp4_url"];;
        self.playCount = [[dic objectForKey:@"playCount"] integerValue];
       self.playersize = [[dic objectForKey:@"playersize"] integerValue];
       self.ptime = [dic objectForKey:@"ptime"];
      self.replyBoard = [dic objectForKey:@"replyBoard"];
      self.replyid = [dic objectForKey:@"replyid"];;
       self.sectiontitle = [dic objectForKey:@"sectiontitle"];
       self.title = [dic objectForKey:@"title"];
       self.topicImg = [dic objectForKey:@"topicImg"];
        self.topicName = [dic objectForKey:@"topicName"];
       self.topicSid = [dic objectForKey:@"topicSid"];
       self.vid = [dic objectForKey:@"vid"];
       
        
    }
    return self;
}

+ (instancetype)modelWithDictionary:(NSDictionary *)dic
{
    return [[[VideoModel class] alloc] initWithDictionary:dic];
}

@end

@implementation videoTopicDicModel

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
    
    return [[[videoTopicDicModel class] alloc] initWithDictionary:dic];
    
}

@end
