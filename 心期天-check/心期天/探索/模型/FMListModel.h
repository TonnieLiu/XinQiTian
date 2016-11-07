//
//  FMListModel.h
//  心期天
//
//  Created by qianfeng on 15/10/26.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import "JSONModel.h"
#import "FMListArrModel.h"

@interface FMListModel : JSONModel
@property(nonatomic,strong)NSMutableArray <FMListArrModel,Optional>*fmidlist;
@property(nonatomic,copy)NSString<Optional>*userId;
@property(nonatomic,copy)NSString<Optional>*name;
@property(nonatomic,copy)NSString<Optional>*photo;
@end
