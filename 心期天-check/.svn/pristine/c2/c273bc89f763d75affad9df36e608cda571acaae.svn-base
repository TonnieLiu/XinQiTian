//
//  ContentTableViewCell.m
//  心期天
//
//  Created by qianfeng on 15/10/23.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import "ContentTableViewCell.h"

@interface ContentTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *hugNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *reolyNumLabel;

@end

@implementation ContentTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)refreshUI:(ContentModel *)mode{
    self.hugNumLabel.text = [NSString stringWithFormat:@"%@人赞",mode.hugnum];
    self.reolyNumLabel.text = [NSString stringWithFormat:@"%@人已回复",mode.replynum];
    self.contentLabel.text = mode.content;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
