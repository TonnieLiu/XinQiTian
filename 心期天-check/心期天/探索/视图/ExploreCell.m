//
//  ExploreCell.m
//  心期天
//
//  Created by qianfeng on 15/10/27.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import "ExploreCell.h"

@interface ExploreCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation ExploreCell
-(void)refreshUI:(NSDictionary *)dict{
    self.headImageView.image = [UIImage imageNamed:dict[@"icon"]];
    self.nameLabel.text = dict[@"name"];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
