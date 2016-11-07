//
//  LJHttpManager.h
//  心期天-项目-1.0
//
//  Created by qianfeng on 15/10/21.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FSAudioStream.h"

typedef void (^complement)(id responseObject,NSError *error);

@interface LJHttpManager : NSObject
+(void)post:(NSString *)url parameters:(NSDictionary *)para complement:(complement)block;
+(void)get:(NSString *)url parameters:(NSDictionary *)para complement:(complement)block;
+(void)setImageView:(UIImageView *)imageView withUrl:(NSString *)url;
+(NSString *)userNum;
+(void)test;
+(FSAudioStream *)audioStream;
+(NSString *)audioStreamPlayFromUrl:(NSString *)str;
+(void)alertViewFromTaget:(id)taget withMessage:(NSString *)message;
@end
