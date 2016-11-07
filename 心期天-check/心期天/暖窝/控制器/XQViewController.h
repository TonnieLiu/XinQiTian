//
//  XQViewController.h
//  心期天
//
//  Created by qianfeng on 15/11/4.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^blockType)(void);

@interface XQViewController : UIViewController
@property (nonatomic,strong)blockType block;
@end
