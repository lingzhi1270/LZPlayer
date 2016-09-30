//
//  VideoCell.h
//  视频播放Demo
//
//  Created by lingzhi on 16/9/29.
//  Copyright © 2016年 lingzhi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoModel.h"


@interface VideoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIImageView *timeImage;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *supportImage;
@property (weak, nonatomic) IBOutlet UILabel *suportLabel;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;

@property (nonatomic,strong)VideoModel *model;

@end
