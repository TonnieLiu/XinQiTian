//
//  FMListCell.h
//  心期天
//
//  Created by qianfeng on 15/10/27.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMListModel.h"

@interface FMListCell : UICollectionViewCell
- (void)refreshUI:(FMListModel *)mode;
@end
