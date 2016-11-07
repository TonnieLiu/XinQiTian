//
//  ActivityCell.m
//  心期天
//
//  Created by qianfeng on 15/10/26.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import "ActivityCell.h"

@interface ActivityCell ()
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *enrollnumLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation ActivityCell
-(void)refreshUI:(ActivityModel *)mode{
    self.cityLabel.text = mode.city;
    [LJHttpManager setImageView:self.photoImageView withUrl:mode.photo];
    self.enrollnumLabel.text = [NSString stringWithFormat:@"报名人数 %@",mode.enrollnum];
    self.titleLabel.text = mode.title;
    self.dateLabel.text = [NSString stringWithFormat:@"活动时间: %@",mode.date];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
