//
//  ActivityViewController.m
//  心期天
//
//  Created by qianfeng on 15/10/28.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import "ActivityViewController.h"
#import "ActivityInfoModel.h"
#import "ActivityInfoCell.h"

@interface ActivityViewController ()
<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *dataArr;
@end

@implementation ActivityViewController
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray new];
    }
    return _dataArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 368.0f;
    [self requestData];
}


#pragma mark-网络数据相关
- (void)requestData{
    [LJHttpManager get:KACINFO_URL parameters:@{@"activityid":self.activityId} complement:^(id responseObject, NSError *error) {
        if (error) {
            NSLog(@"error = %@",error);
        } else {
            ActivityInfoModel *mode = [[ActivityInfoModel alloc] initWithDictionary:responseObject[@"data"] error:nil];
            [self.dataArr addObject:mode];
            [self.tableView reloadData];
        }
    }];
}
#pragma mark-UITableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ActivityInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ActivityInfoCell"];
    [cell refreshUI:self.dataArr[indexPath.row]];
    return cell;
}
#pragma mark -点击事件
- (IBAction)joinaAction:(id)sender {
#warning 该功能需要线上支付
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"该功能需要登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}



@end
