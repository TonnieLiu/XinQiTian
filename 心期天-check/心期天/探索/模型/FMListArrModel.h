//
//  FMListArrModel.h
//  心期天
//
//  Created by qianfeng on 15/10/26.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import "JSONModel.h"

@protocol FMListArrModel <NSObject>


@end

@interface FMListArrModel : JSONModel
@property (nonatomic,copy)NSString <Optional>*userId;
@end
