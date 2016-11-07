//
//  ResultViewController.m
//  心期天
//
//  Created by qianfeng on 15/11/4.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import "ResultViewController.h"

@interface ResultViewController ()
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@end

@implementation ResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showResult];
    
}
- (void)showResult{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"shape-22"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    if (self.mark == 0) {
        self.resultLabel.text = @"数据有误,请重新测试";
    } else if (self.mark > 0 && self.mark <= 10) {
        self.resultLabel.text = @"沟通能力比较差，有时你想要表达的意思常常被别人误解，容易给别人留下不好的印象，甚至无意中对别人造成伤害，建议增加相关方面的知识和训练。";
    } else if (self.mark > 10 && self.mark <= 20) {
        self.resultLabel.text = @"沟通能力中等，你的沟通能力发挥得不稳定，有时会引起沟通障碍，建议提升自己的沟通能力。";
    } else {
        self.resultLabel.text = @"沟通能力很强，你是沟通高手，口头表达能力强，说话简明扼要，很容易让对方接受你的观点。";
    }
}
- (void)back{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
