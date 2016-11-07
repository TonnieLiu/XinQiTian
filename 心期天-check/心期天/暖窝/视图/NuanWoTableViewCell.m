//
//  NuanWoTableViewCell.m
//  心期天
//
//  Created by qianfeng on 15/10/25.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import "NuanWoTableViewCell.h"

@interface NuanWoTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *hugNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *vipImageView;
@property (weak, nonatomic) IBOutlet UIButton *hugButton;
@property (nonatomic,strong)NuanWoModel *mode;
@end

@implementation NuanWoTableViewCell
-(void)refreshUI:(NuanWoModel *)mode{
    self.mode = mode;
    [LJHttpManager setImageView:self.headImageView withUrl:mode.photo];
    if ([mode.hug_status isEqualToString:@"no"]) {
        self.hugButton.selected = NO;
        self.hugButton.enabled = YES;
    } else {
        self.hugButton.selected = YES;
        self.hugButton.enabled = NO;
    }
    self.headImageView.layer.cornerRadius = 25;
    self.nameLabel.text = mode.name;
    self.cityLabel.text = mode.address;
    self.hugNumLabel.text = mode.hugnum;
    self.contentLabel.text = [mode.content stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self setContentLabelColor:mode.zitiColor];
    self.timeLabel.text = [self getTimeWithLastTime:mode.addtime];
    if ([mode.huiyuan isEqualToString:@"1"]) {
        self.vipImageView.hidden = NO;
        self.nameLabel.textColor = [UIColor orangeColor];
    } else {
        self.vipImageView.hidden = YES;
        self.nameLabel.textColor = [UIColor blackColor];
    }
    
}
- (void)setContentLabelColor:(NSString *)colorStr{
    if ([colorStr isEqualToString:@"red"]) {
        self.contentLabel.textColor = [UIColor redColor];
    } else if ([colorStr isEqualToString:@"orange"]){
        self.contentLabel.textColor = [UIColor orangeColor];
    } else if ([colorStr isEqualToString:@"purple"]){
        self.contentLabel.textColor = [UIColor purpleColor];
    } else if ([colorStr isEqualToString:@"blue"]) {
        self.contentLabel.textColor = [UIColor blueColor];
    } else if ([colorStr isEqualToString:@"yellow"]) {
        self.contentLabel.textColor = [UIColor yellowColor];
    } else {
        self.contentLabel.textColor = [UIColor blackColor];
    }
}
- (NSString *)getTimeWithLastTime:(NSString *)dateString{
    NSDateFormatter *formatter =  [NSDateFormatter new];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *date = [formatter dateFromString:dateString];
    long long distanceSecond = 0 - [date timeIntervalSinceNow];
    if (distanceSecond > (3600 * 24)) {
        return [NSString stringWithFormat:@"%lld天前",distanceSecond /3600 / 24];
    } else {
        return [NSString stringWithFormat:@"%lld小时前",distanceSecond / 3600];
    }
}
- (IBAction)hugAvtion:(UIButton *)sender {
    if ([LJHttpManager userNum].length == 0) {
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请登录后再操作" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alterView show];
    } else {
        NSString *link = [NSString stringWithFormat:@"%@/contentid/%@/userid/%@/usertype/%@",KHUG_URL,self.mode.userId,[LJHttpManager userNum],self.mode.usertype];
        NSLog(@"link = %@",link);
        [LJHttpManager get:[NSString stringWithFormat:@"%@/contentid/%@/userid/%@/usertype/%@",KHUG_URL,self.mode.userId,[LJHttpManager userNum],self.mode.usertype] parameters:nil complement:^(id responseObject, NSError *error) {
            if (error) {
                NSLog(@"error = %@",error);
            } else {
                self.hugNumLabel.text = [NSString stringWithFormat:@"%@",responseObject[@"hugnum"]];
                sender.selected = YES;
            }
        }];
    }
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
