//
//  ProvinceModel.m
//  心期天
//
//  Created by qianfeng on 15/10/31.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import "ProvinceModel.h"
#import "CityModel.h"

@implementation ProvinceModel
-(NSMutableArray *)cityArr{
    if (!_cityArr) {
        _cityArr = [NSMutableArray new];
    }
    return _cityArr;
}
-(void)setCityArr:(NSMutableArray *)cityArr{
    for (NSString *city in cityArr) {
        CityModel *mode = [CityModel new];
        mode.city = city;
        [self.cityArr addObject:mode];
    }
}
@end
