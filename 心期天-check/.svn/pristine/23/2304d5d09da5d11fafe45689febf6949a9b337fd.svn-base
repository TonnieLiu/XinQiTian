//
//  CodeViewController.m
//  心期天
//
//  Created by qianfeng on 15/10/31.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import "CodeViewController.h"

@interface CodeViewController ()
@property (nonatomic,assign)NSInteger time;
@property (weak, nonatomic) IBOutlet UIButton *againBtn;
@end

@implementation CodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.time = 60;
    self.againBtn.enabled = NO;
    [[NSRunLoop currentRunLoop] addTimer:[NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(tryAgain) userInfo:nil repeats:YES] forMode:NSRunLoopCommonModes];
}
- (void)tryAgain{
    if (self.time) {
        [self.againBtn setTitle:[NSString stringWithFormat:@"%ld秒后重试",self.time--] forState:UIControlStateDisabled];
        [self.againBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    } else {
        [self.againBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.againBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.time = 0;
        self.againBtn.enabled = YES;
    }
    
}
- (IBAction)againAction:(UIButton *)sender {
    NSLog(@"time test");
    [LJHttpManager get:KREGISTER_URL parameters:@{@"mobile":self.phoneNum} complement:^(id responseObject, NSError *error) {
        if (error) {
            NSLog(@"error = %@",error);
        } else {
            if ([responseObject[@"code"] isEqualToString:@"1"]) {
                self.time = 60;
            } else {
                [LJHttpManager alertViewFromTaget:self withMessage:responseObject[@"msg"]];
            }
        }
    }];

}

@end
