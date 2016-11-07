//
//  FMListCell.m
//  心期天
//
//  Created by qianfeng on 15/10/27.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import "FMListCell.h"

@interface FMListCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation FMListCell
-(void)refreshUI:(FMListModel *)mode{
    self.titleLabel.text = mode.name;
    [LJHttpManager setImageView:self.headerImageView withUrl:mode.photo];
}
@end
