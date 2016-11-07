//
//  LoginViewController.h
//  心期天
//
//  Created by qianfeng on 15/10/29.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginModel.h"

typedef void (^updateHeader)(LoginModel *mode);

@interface LoginViewController : UIViewController
@property (nonatomic,strong)updateHeader block;
@end
