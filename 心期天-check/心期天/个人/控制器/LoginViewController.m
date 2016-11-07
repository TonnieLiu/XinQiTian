//
//  LoginViewController.m
//  心期天
//
//  Created by qianfeng on 15/10/29.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import "LoginViewController.h"
#import "AFNetworking.h"

@interface LoginViewController ()
<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}
#pragma mark-头像
- (IBAction)loginAction:(id)sender {
    if (self.passwordTextField.text.length == 0 || self.usernameTextField.text.length == 0) {
        [LJHttpManager alertViewFromTaget:self withMessage:@"手机号或密码不能为空"];
    } else {
//        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:KLOGIN_URL]];
//        request.HTTPMethod = @"POST";
//        request.HTTPBody = [[NSString stringWithFormat:@"pwd=%@&username=%@",self.passwordTextField.text,self.usernameTextField.text] dataUsingEncoding:NSUTF8StringEncoding];
//        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//            NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//            if ([responseObject[@"message"] isEqualToString:@"密码错误"]) {
//                
//            } else if ([responseObject[@"message"] isEqualToString:@"success"]){
//                NSLog(@"%@",responseObject[@"result"]);
////                LoginModel *mode = responseObject[@"result"];
////                NSString *path = [[NSBundle mainBundle] pathForResource:@"InforPlist" ofType:@"plist"];
////                NSMutableDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path][@"Infor"];
////                [dict setObject:mode.user_id forKey:@"userid"];
////                [dict writeToFile:path atomically:YES];
////                self.block(mode);
//            }
//            
//        }];

        [LJHttpManager post:KLOGIN_URL parameters:@{@"pwd":self.passwordTextField.text,@"username":self.usernameTextField.text} complement:^(id responseObject, NSError *error) {
            if (error) {
                NSLog(@"error = %@",error);
            } else {
                if ([responseObject[@"message"] isEqualToString:@"密码错误"]) {
                    [LJHttpManager alertViewFromTaget:self withMessage:responseObject[@"message"]];
                } else if ([responseObject[@"message"] isEqualToString:@"success"]){
                    NSLog(@"%@",responseObject);
                    LoginModel *mode = [[LoginModel alloc] initWithDictionary:responseObject[@"result"][0] error:nil] ;
                    //NSLog(@"%@%@",)
                    //NSString *path = [[NSBundle mainBundle] pathForResource:@"InforPlist" ofType:@"plist"];
                    NSString *path = [NSHomeDirectory() stringByAppendingString:@"/infor.plist"];
                    
                    NSLog(@"path = %@",path);
                    NSMutableDictionary *dict = [NSMutableDictionary new];
                    
                    NSLog(@"%@",mode.user_id);
                    [dict setObject:mode.user_id forKey:@"userid"];
                    [dict setObject:mode.name forKey:@"name"];
                    [dict setObject:mode.photo forKey:@"photo"];
                    [dict setObject:self.usernameTextField.text forKey:@"tel"];
                    [dict writeToFile:path atomically:YES];
                    
                    self.block(mode);
                    [self.navigationController popToRootViewControllerAnimated:YES];
                    //[NSUserDefaults standardUserDefaults]
                 }
            }
            
        }];

    }
}
#pragma mark-textfield代理方法
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    
    return YES;
}
@end
