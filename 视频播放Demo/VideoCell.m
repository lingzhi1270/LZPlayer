//
//  VideoCell.m
//  视频播放Demo
//
//  Created by lingzhi on 16/9/29.
//  Copyright © 2016年 lingzhi. All rights reserved.
//

#import "VideoCell.h"
#import "UIImageView+WebCache.h"


@implementation VideoCell

- (void)awakeFromNib {
    [super awakeFromNib];

    
}


#pragma mark- setter

- (void)setModel:(VideoModel *)model
{
    _model = model;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.titleLabel.text = model.title;
    self.contentLabel.text = model.descriptionDe;
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:[UIImage imageNamed:@"logo"]];
    
 
    self.timeLabel.text = [model.ptime substringWithRange:NSMakeRange(12, 4)];
    self.suportLabel.text = [NSString stringWithFormat:@"%ld.%ld万",model.playCount/10000,model.playCount/1000-model.playCount/10000];    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

   
    
    
}

@end
