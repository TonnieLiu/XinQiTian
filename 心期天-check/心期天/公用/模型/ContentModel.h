//
//  ContentModel.h
//  心期天
//
//  Created by qianfeng on 15/10/23.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import "JSONModel.h"
#import "DetailModel.h"

@interface ContentModel : JSONModel
@property(nonatomic,copy)NSString <Optional>*content;//,
@property(nonatomic,copy)NSString <Optional>*hugnum;// @property(nonatomic,copy)NSString <Optional>*3@property(nonatomic,copy)NSString <Optional>*,
@property(nonatomic,copy)NSString <Optional>*message;// @property(nonatomic,copy)NSString <Optional>*请求成功@property(nonatomic,copy)NSString <Optional>*,
@property(nonatomic,copy)NSString <Optional>*replynum;// @property(nonatomic,copy)NSString <Optional>*1@property(nonatomic,copy)NSString <Optional>*,
@property(nonatomic,copy)NSString <Optional>*status;// @property(nonatomic,copy)NSString <Optional>*1@property(nonatomic,copy)NSString <Optional>*,
@property(nonatomic,copy)NSString <Optional>*ziticolor;// @property(nonatomic,copy)NSString <Optional>*black@property(nonatomic,copy)NSString <Optional>*
@property(nonatomic,strong)NSMutableArray<DetailModel> *list;
@end
