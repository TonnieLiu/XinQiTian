//
//  ActivityInfoCell.m
//  心期天
//
//  Created by qianfeng on 15/10/29.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import "ActivityInfoCell.h"

@interface ActivityInfoCell ()
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *speakLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *feeLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end

@implementation ActivityInfoCell
-(void)refreshUI:(ActivityInfoModel *)mode{
    self.dateLabel.text = mode.date;
    self.speakLabel.text = mode.speakperson;
    self.addressLabel.text = mode.address;
    self.phoneLabel.text = mode.phone;
    self.feeLabel.text = mode.fee;
    self.detailLabel.text = mode.detail;
    [LJHttpManager setImageView:self.photoImageView withUrl:mode.photo2];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
