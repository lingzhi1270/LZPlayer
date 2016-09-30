//
//  VideoModel.h
//  视频播放Demo
//
//  Created by lingzhi on 16/9/29.
//  Copyright © 2016年 lingzhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoModel : NSObject
@property (nonatomic,strong)NSString *cover;
@property (nonatomic,strong)NSString *descriptionDe;
@property (nonatomic,assign)NSInteger length;
@property (nonatomic,strong)NSString *m3u8Hd_url;
@property (nonatomic,strong)NSString *m3u8_url;
@property (nonatomic,strong)NSString *mp4Hd_url;
@property (nonatomic,strong)NSString *mp4_url;
@property (nonatomic,assign)NSInteger playCount;
@property (nonatomic,assign)NSInteger playersize;
@property (nonatomic,strong)NSString *ptime;
@property (nonatomic,strong)NSString *replyBoard;
@property (nonatomic,strong)NSString *replyid;
@property (nonatomic,strong)NSString *sectiontitle;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *topicImg;
@property (nonatomic,strong)NSString *topicName;
@property (nonatomic,strong)NSString *topicSid;
@property (nonatomic,strong)NSString *vid;
//字典
@property (nonatomic,strong)NSDictionary *videoTopicDic;
@property (nonatomic,strong)NSString *videosource;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

+ (instancetype)modelWithDictionary:(NSDictionary *)dic;
@end

@interface videoTopicDicModel : NSObject

@property (nonatomic,strong)NSString *alias;
@property (nonatomic,strong)NSString *ename;
@property (nonatomic,strong)NSString *tid;
@property (nonatomic,strong)NSString *tname;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

+ (instancetype)modelWithDictionary:(NSDictionary *)dic;
@end
