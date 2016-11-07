//
//  LJHttpManager.m
//  心期天-项目-1.0
//
//  Created by qianfeng on 15/10/21.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import "LJHttpManager.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "AppDelegate.h"


@implementation LJHttpManager
+(void)post:(NSString *)url parameters:(NSDictionary *)para complement:(complement)block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:url parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block(responseObject,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
}
+(void)get:(NSString *)url parameters:(NSDictionary *)para complement:(complement)block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block(responseObject,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
}
+(void)setImageView:(UIImageView *)imageView withUrl:(NSString *)url{
    [imageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",KHOST_URL,url]] placeholderImage:[UIImage imageNamed:@"加载图"]];
}
+(void)test{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"InforPlist" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    NSLog(@"%@",dict[@"Infor"]);
}
+(NSString *)userNum{
    NSString *path = [NSHomeDirectory() stringByAppendingString:@"/infor.plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    if ([dict[@"userid"] length] != 0) {
        return dict[@"userid"];
    } else {
        return @"";
    }
    
}
+(NSString *)audioStreamPlayFromUrl:(NSString *)str{
    static NSString *url;
    if(str != nil){
        url = str;
        AppDelegate *del = [UIApplication sharedApplication].delegate;
        FSAudioStream *audioStream = del.audioStream;
        [audioStream playFromURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",KHOST_URL,url]]];
    }
    return url;
}
+(FSAudioStream *)audioStream{
    AppDelegate *del = [UIApplication sharedApplication].delegate;
    return del.audioStream;
}
+(void)alertViewFromTaget:(id)taget withMessage:(NSString *)message{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:message delegate:taget cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}
@end
