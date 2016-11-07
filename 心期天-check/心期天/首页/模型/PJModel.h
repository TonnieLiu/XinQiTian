//
//  PJModel.h
//  心期天
//
//  Created by qianfeng on 15/11/3.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import "JSONModel.h"

@protocol PJModel <NSObject>


@end

@interface PJModel : JSONModel
@property (nonatomic,copy)NSString <Optional>*comment;//\r\n老师很细心、专业，我对生活重新燃起了希望。好象脑子突然就开窍了，老师的话句句点中了我的心。谢谢老师，我会再来咨询的。你真的是位优秀的心理咨询师。@property (nonatomic,copy)NSString <Optional>*,
@property (nonatomic,copy)NSString <Optional>*name;//2222@property (nonatomic,copy)NSString <Optional>*,
@property (nonatomic,copy)NSString <Optional>*rtime;//2015-09-11 15:19:35@property (nonatomic,copy)NSString <Optional>*,
@property (nonatomic,copy)NSString <Optional>*star;//5@property (nonatomic,copy)NSString <Optional>*
@end
