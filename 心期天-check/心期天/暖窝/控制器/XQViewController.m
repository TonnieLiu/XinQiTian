//
//  XQViewController.m
//  心期天
//
//  Created by qianfeng on 15/11/4.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import "XQViewController.h"

@interface XQViewController ()
<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@end

@implementation XQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(returnAction)];
}

- (void)returnAction{
    if (self.textField.text.length) {
        [LJHttpManager get:KRETURN_URL parameters:@{@"userid":[LJHttpManager userNum],@"content":self.textField.text,@"ziticolor":@"black",@"distinct":@"深圳市"} complement:^(id responseObject, NSError *error) {
            if (error) {
                NSLog(@"error = %@",error);
            } else {
                if ([responseObject[@"status"] isEqualToString:@"1"]) {
                    self.block();
                    [self.navigationController popViewControllerAnimated:YES];
                } else {
                    [LJHttpManager alertViewFromTaget:self withMessage:responseObject[@"message"]];
                }
            }
        }];
    } else {
        [LJHttpManager alertViewFromTaget:self withMessage:@"内容为空"];
    }
    
}
#pragma mark-UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
@end
