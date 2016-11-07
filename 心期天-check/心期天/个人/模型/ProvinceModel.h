//
//  ProvinceModel.h
//  心期天
//
//  Created by qianfeng on 15/10/31.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProvinceModel : NSObject{
    NSMutableArray *_cityArr;
}
@property (nonatomic,strong)NSMutableArray *cityArr;
@property (nonatomic,copy)NSString *province;
@end
