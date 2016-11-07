//
//  RollPhotoModel.m
//  心期天
//
//  Created by qianfeng on 15/10/23.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import "RollPhotoModel.h"

@implementation RollPhotoModel
+(JSONKeyMapper *)keyMapper{
    
    //返回JSONKeyMapper这个对象
    //字典的key值为服务器提供的字段名
    //字典的value值为我们类声明的字段名
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"userId"}];
    
    
}

@end
