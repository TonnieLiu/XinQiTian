//
//  PhotoViewController.m
//  心期天
//
//  Created by qianfeng on 15/10/23.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import "PhotoViewController.h"
#import "UMSocial.h"

@interface PhotoViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic,copy)NSString *shareStr;
@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    if (self.type) {
//        
//    }
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"share"] style:UIBarButtonItemStyleDone target:self action:@selector(shareAction)];
    [LJHttpManager get:KPHOTO_URL parameters:@{@"essayid":self.essayid} complement:^(id responseObject, NSError *error) {
        if (error) {
            NSLog(@"error = %@",error);
        } else {
            self.shareStr = [NSString stringWithFormat:@"%@%@",KHOST_URL,responseObject[@"data"][@"contenthtml"]];
            [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.shareStr]]];
        }
    }];
}
- (void)shareAction{
    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"562d8156e0f55a1a88006ebd" shareText:self.shareStr shareImage:[UIImage imageNamed:@"icon.png"] shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToDouban,UMShareToRenren,UMShareToTencent,nil] delegate:nil];
}


@end
