//
//  DataManager.m
//  视频播放Demo
//
//  Created by lingzhi on 16/9/29.
//  Copyright © 2016年 lingzhi. All rights reserved.
//

#import "DataManager.h"
#import "AFNetworking.h"
#import "SidModel.h"
#import "VideoModel.h"

@implementation DataManager

+ (DataManager *)shareDataManager
{
    static DataManager *manager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        manager = [[[self class] alloc] init];
    });
    return manager;
}

- (void)getSidArrayWithUrlString:(NSString *)urlString success:(SuccessBlock)success failed:(FailedBlock)failed
{

    /*
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
//    sessionManager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"text/plain", nil];
    
    [sessionManager POST:urlString parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
//        NSLog(@"responseObject = %@",responseObject);
        
        NSMutableArray *sidArr = [[NSMutableArray alloc] initWithCapacity:0];
        NSMutableArray *videoArr = [[NSMutableArray alloc] initWithCapacity:0];
      
        for (NSDictionary *videoDic in [responseObject objectForKey:@"videoList"]) {
            VideoModel *model = [VideoModel modelWithDictionary:videoDic];
            [videoArr addObject:model];
        }
        self.videoArray = [NSArray arrayWithArray:videoArr];
        
        for (NSDictionary *sidDic in [responseObject objectForKey:@"videoSidList"]) {
            SidModel *model = [SidModel modelWithDictionary:sidDic];
            [sidArr addObject:model];
        }
        self.sidArray = [NSArray arrayWithArray:sidArr];
        
        if (success) {
            success(sidArr,videoArr);
        }
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"error = %@",error);
        if (failed) {
            failed(error);
        }
    }];
     */
    
    
    //这个请求  视频播放更流畅
    dispatch_queue_t global_t = dispatch_get_global_queue(0, 0);
    dispatch_async(global_t, ^{
        NSURL *url = [NSURL URLWithString:urlString];
        NSMutableArray *sidArray = [NSMutableArray array];
        NSMutableArray *videoArray = [NSMutableArray array];
        
        
        [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * response, NSData *  data, NSError *  connectionError) {
            if (connectionError) {
                NSLog(@"错误%@",connectionError);
                failed(connectionError);
            }else{
                NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                for (NSDictionary * video in [dict objectForKey:@"videoList"]) {
                    VideoModel * model = [VideoModel modelWithDictionary:video];
                    [videoArray addObject:model];
                }
                self.videoArray = [NSArray arrayWithArray:videoArray];
                // 加载头标题
                for (NSDictionary *d in [dict objectForKey:@"videoSidList"]) {
                    SidModel *model= [SidModel modelWithDictionary:d];
                    [sidArray addObject:model];
                }
                self.sidArray = [NSArray arrayWithArray:sidArray];
                
            }
            success(sidArray,videoArray);
            
        }];
        
    });
    
}

- (void)getVideoListWithUrlString:(NSString *)urlString success:(SuccessBlock)success failed:(FailedBlock)failed
{
    
}

@end
