//
//  TestCell.m
//  心期天
//
//  Created by qianfeng on 15/11/4.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import "TestCell.h"

@interface TestCell ()
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation TestCell
-(void)refreshUI:(TitleLabel *)str{
    self.contentLabel.text = str.content;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
