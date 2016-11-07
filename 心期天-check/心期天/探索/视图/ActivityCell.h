//
//  ActivityCell.h
//  心期天
//
//  Created by qianfeng on 15/10/26.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityModel.h"

@interface ActivityCell : UITableViewCell
- (void)refreshUI:(ActivityModel *)mode;
@end
