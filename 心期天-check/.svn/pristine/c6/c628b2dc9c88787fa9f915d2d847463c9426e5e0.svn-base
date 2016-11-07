//
//  TabBarViewController.m
//  心期天-项目-1.0
//
//  Created by qianfeng on 15/10/21.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import "TabBarViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Tabbar" ofType:@"plist"];    
    NSArray *itemsArr = [NSDictionary dictionaryWithContentsOfFile:path][@"Items"];
    for (NSInteger i = 0; i < 4; i ++) {
        UIViewController *ctl = self.viewControllers[i];
        ctl.tabBarItem.title = itemsArr[i][@"title"];
        ctl.tabBarItem.image = [UIImage imageNamed:itemsArr[i][@"imageName"]];
        ctl.tabBarItem.selectedImage = [UIImage imageNamed:itemsArr[i][@"selectImageName"]];
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
