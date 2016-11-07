//
//  RegisterViewController.m
//  心期天
//
//  Created by qianfeng on 15/10/31.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import "RegisterViewController.h"
#import "CodeViewController.h"

@interface RegisterViewController ()
<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)registerAction:(id)sender {
    if (self.phoneTextField.text.length != 0) {
        [LJHttpManager get:KREGISTER_URL parameters:@{@"mobile":self.phoneTextField.text} complement:^(id responseObject, NSError *error) {
            if (error) {
                NSLog(@"error = %@",error);
            } else {
                if ([responseObject[@"code"] isEqualToString:@"1"]) {
                    [self performSegueWithIdentifier:@"CodeSegue" sender:nil];
                } else {
                    [LJHttpManager alertViewFromTaget:self withMessage:responseObject[@"msg"]];
                }
            }
        }];
        
    } else {
        [LJHttpManager alertViewFromTaget:self withMessage:@"手机号不能为空"];
    }
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    CodeViewController *ctl = segue.destinationViewController;
    ctl.phoneNum = self.phoneTextField.text;
}
#pragma mark-UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


@end
