//
//  ZJModel.h
//  心期天
//
//  Created by qianfeng on 15/11/3.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import "JSONModel.h"
#import "PJModel.h"

@interface ZJModel : JSONModel

@property (nonatomic,copy)NSString <Optional>*age;//25@property (nonatomic,copy)NSString <Optional>*,
@property (nonatomic,copy)NSString <Optional>*conFee;//0@property (nonatomic,copy)NSString <Optional>*,
@property (nonatomic,copy)NSString <Optional>*memFee;//0@property (nonatomic,copy)NSString <Optional>*,
@property (nonatomic,copy)NSString <Optional>*message;//有此咨询师@property (nonatomic,copy)NSString <Optional>*,
@property (nonatomic,copy)NSString <Optional>*name;//解梦人@property (nonatomic,copy)NSString <Optional>*,
@property (nonatomic,copy)NSString <Optional>*photo2;///Public/Uploads/20150828/55dffc241bd1e.png@property (nonatomic,copy)NSString <Optional>*,
@property (nonatomic,copy)NSString <Optional>*skilled;//曼陀罗绘画 解梦人 离异家庭@property (nonatomic,copy)NSString <Optional>*
@property (nonatomic,copy)NSString <Optional>*edu;//硕士@property (nonatomic,copy)NSString <Optional>*,
@property (nonatomic,copy)NSString <Optional>*detail;//
@property (nonatomic,strong)NSMutableArray <PJModel,Optional>*list;
@end
