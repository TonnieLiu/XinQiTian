//
//  PersonCell.m
//  心期天
//
//  Created by qianfeng on 15/10/29.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import "PersonCell.h"

@interface PersonCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation PersonCell
-(void)refreshUI:(PersonCellModel *)mode{
    self.iconImageView.image = [UIImage imageNamed:mode.icon];
    self.nameLabel.text = mode.name;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
