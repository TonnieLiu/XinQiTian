//
//  FMReplyCell.m
//  心期天
//
//  Created by qianfeng on 15/10/28.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import "FMReplyCell.h"

@interface FMReplyCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UIImageView *vipImageView;

@end

@implementation FMReplyCell
-(void)refreshUI:(FMReplyModel *)mode{
    self.nameLabel.text = mode.name;
    self.timeLabel.text = [self getTimeWithLastTime:mode.addtime];
    self.contentLabel.text = mode.content;
    self.headerImageView.layer.cornerRadius = 25;
    [LJHttpManager setImageView:self.headerImageView withUrl:mode.photo];
    if ([mode.huiyuan isEqualToString:@"1"]) {
        self.vipImageView.hidden = NO;
    } else {
        self.vipImageView.hidden = YES;
    }
}
- (NSString *)getTimeWithLastTime:(NSString *)dateString{
    NSDateFormatter *formatter =  [NSDateFormatter new];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *date = [formatter dateFromString:dateString];
    long long distanceSecond = 0 - [date timeIntervalSinceNow];
    if (distanceSecond > 3600 * 24 * 30) {
        return [NSString stringWithFormat:@"%lld月前评论",distanceSecond/ 3600 / 24 / 30];
    } else if (distanceSecond > (3600 * 24)) {
        return [NSString stringWithFormat:@"%lld天前评论",distanceSecond / 3600 / 24];
    } else {
        return [NSString stringWithFormat:@"%lld小时前评论",distanceSecond / 3600];
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
