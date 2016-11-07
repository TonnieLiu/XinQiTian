//
//  PersonCellModel.h
//  心期天
//
//  Created by qianfeng on 15/10/29.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import "JSONModel.h"

@interface PersonCellModel : JSONModel
@property (nonatomic,copy)NSString <Optional>*name;
@property (nonatomic,copy)NSString <Optional>*icon;
@property (nonatomic,copy)NSString <Optional>*link;
@end
