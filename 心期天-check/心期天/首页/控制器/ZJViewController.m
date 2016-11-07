//
//  ZJViewController.m
//  心期天
//
//  Created by qianfeng on 15/11/3.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import "ZJViewController.h"
#import "ZJModel.h"
#import "Masonry.h"

@interface ZJViewController ()
<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *width;
@property (weak, nonatomic) IBOutlet UIImageView *pickImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *conFeeLabel;
@property (weak, nonatomic) IBOutlet UILabel *memFeeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *rectImageView;
@property (weak, nonatomic) IBOutlet UIImageView *roundImageView;
@property (weak, nonatomic) IBOutlet UILabel *skilledLabel;
@property (weak, nonatomic) IBOutlet UITextView *detailTextView;
@property (weak, nonatomic) IBOutlet UILabel *listNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *listRtimeLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *startWidth;
@property (weak, nonatomic) IBOutlet UILabel *commemtLabel;

@property (nonatomic,strong)NSArray *dataArr;
@end

@implementation ZJViewController
-(NSArray *)dataArr{
    if (!_dataArr) {
        _dataArr = @[@"基本信息",@"主攻放向",@"详细资料",@"用户评价"];
    }
    return _dataArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.width.constant = KMainScreenWidth * 4;
    [self requestData];
}

#pragma mark-网络数据相关
-(void)requestData{
    [LJHttpManager get:KCONDISINFO_URL parameters:@{@"id":self.userId}complement:^(id responseObject, NSError *error) {
        if (error) {
            NSLog(@"error = %@",error);
        } else {
            ZJModel *mode = [[ZJModel alloc] initWithDictionary:responseObject error:nil];
            [self updateScrollView:mode];
        }
    }];
}
- (void)updateScrollView:(ZJModel *)mode{
    [LJHttpManager setImageView:self.rectImageView withUrl:mode.photo2];
    [LJHttpManager setImageView:self.roundImageView withUrl:mode.photo2];
    self.roundImageView.layer.cornerRadius = 50;
    self.nameLabel.text = mode.name;
    self.ageLabel.text = mode.age;
    self.conFeeLabel.text = mode.conFee;
    self.memFeeLabel.text = mode.memFee;
    self.skilledLabel.text = mode.skilled;
    self.detailTextView.text = mode.detail;
    self.listNameLabel.text = [mode.list[0] name];
    self.listRtimeLabel.text = [mode.list[0] rtime];
    self.commemtLabel.text = [mode.list[0] comment];
    self.startWidth.constant = self.startWidth.constant * ([[mode.list[0] star] integerValue] / 5 );
}
- (void)changePickView:(NSInteger)num{
    self.pickImageView.image = [UIImage imageNamed:self.dataArr[num]];
}
#pragma mark-UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x == 0) {
        [self changePickView:0];
    } else if (scrollView.contentOffset.x == KMainScreenWidth) {
        [self changePickView:1];
    } else if (scrollView.contentOffset.x == KMainScreenWidth * 2) {
        [self changePickView:2];
    } else if (scrollView.contentOffset.x == KMainScreenWidth * 3) {
        [self changePickView:3];
    }
}
@end
