//
//  DetailTableViewCell.h
//  心期天
//
//  Created by qianfeng on 15/10/23.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailModel.h"

@interface DetailTableViewCell : UITableViewCell
-(void)refreshUI:(DetailModel *)mode;
@end
