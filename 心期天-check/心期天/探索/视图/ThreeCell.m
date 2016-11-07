//
//  ThreeCell.m
//  心期天
//
//  Created by qianfeng on 15/10/27.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import "ThreeCell.h"
#import "FMListModel.h"

@interface ThreeCell ()
@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;
@property (weak, nonatomic) IBOutlet UILabel *bigLabel;
@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
@property (weak, nonatomic) IBOutlet UIImageView *bottomImageView;
@property (weak, nonatomic) IBOutlet UILabel *bottomLabel;
@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@end

@implementation ThreeCell
-(void)refreshUI:(NSMutableArray *)dataArr{
    for (NSInteger i = 0; i < 3; i ++) {
        UIImageView *imgView = (UIImageView *)[self viewWithTag:10 + i];
        UILabel *label = (UILabel *)[self viewWithTag:20 + i];
        [LJHttpManager setImageView:imgView withUrl:[dataArr[i] photo]];
        label.text = [dataArr[i] name];
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToFMDetail:)];
        [imgView addGestureRecognizer:tapGes];
        imgView.userInteractionEnabled = YES;
    }
    
}
- (void)pushToFMDetail:(UIGestureRecognizer *)ges{
    NSLog(@"test:%ld",ges.view.tag - 10);
    self.block(ges.view.tag - 10);
}
@end
