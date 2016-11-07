//
//  FMModel.h
//  心期天
//
//  Created by qianfeng on 15/10/26.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import "JSONModel.h"
#import "FMDetailModel.h"
#import "FMReplyModel.h"

@interface FMModel : JSONModel
@property(nonatomic,strong)FMDetailModel <FMDetailModel,Optional>*list;
@property(nonatomic,copy)NSString <Optional>*mp3length;
@property(nonatomic,strong)NSMutableArray <FMReplyModel,Optional>*replylist;
@end
