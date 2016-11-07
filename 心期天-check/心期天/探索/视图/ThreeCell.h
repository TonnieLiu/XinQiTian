//
//  ThreeCell.h
//  心期天
//
//  Created by qianfeng on 15/10/27.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^pushToDetail)(NSInteger tag);

@interface ThreeCell : UICollectionViewCell
- (void)refreshUI:(NSMutableArray *)dataArr;
@property (nonatomic,strong)pushToDetail block;
@end
