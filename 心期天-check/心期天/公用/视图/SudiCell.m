//
//  SudiCell.m
//  心期天
//
//  Created by qianfeng on 15/11/3.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import "SudiCell.h"

@interface SudiCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *rtimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *photo;
@property (weak, nonatomic) IBOutlet UIWebView *contentWebView;


@end

@implementation SudiCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)refreshUI:(SudiModel *)mode{
    self.titleLabel.text = mode.title;
    self.rtimeLabel.text = mode.rtime;
    [self.contentWebView loadHTMLString:mode.content baseURL:nil];
    [LJHttpManager setImageView:self.photo withUrl:mode.photo];
}

@end
