//
//  SudiViewController.m
//  心期天
//
//  Created by qianfeng on 15/11/3.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import "SudiViewController.h"
#import "MJRefresh.h"
#import "SudiCell.h"
#import "SudiModel.h"
#import "PhotoViewController.h"

@interface SudiViewController ()
<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,assign)NSInteger page;
@property (nonatomic,strong)NSMutableArray *dataArr;
@end

@implementation SudiViewController
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray new];
    }
    return _dataArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    [self createRefresh];
    [self requestData];
}
#pragma mark-上下拉刷新
- (void)createRefresh{
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self requestData];
    }];
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.page ++;
        [self requestData];
    }];
}
#pragma mark-网络数据相关
- (void)requestData{
    //NSLog(@"link = %@",self.link);
    [LJHttpManager get:[NSString stringWithFormat:@"%@/%ld",self.link,self.page] parameters:nil complement:^(id responseObject, NSError *error) {
        if (error) {
            NSLog(@"error = %@",error);
        } else {
            //NSLog(@"%@",responseObject);
            if (self.tableView.header.isRefreshing) {
                [self.dataArr removeAllObjects];
            }
            for (NSDictionary *dict in responseObject[@"data"][@"list"]) {
                SudiModel *mode = [[SudiModel alloc] initWithDictionary:dict error:nil];
                [self.dataArr addObject:mode];
            }
            [self.tableView reloadData];
            [self.tableView.header endRefreshing];
            [self.tableView.footer endRefreshing];
        }
    }];
}
#pragma mark-UITableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SudiCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SudiCell"];
    [cell refreshUI:self.dataArr[indexPath.row]];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PhotoViewController *ctl = [[PhotoViewController alloc] init];
    ctl.title = self.title;
    ctl.essayid = [self.dataArr[indexPath.row] userId];
    [self.navigationController pushViewController:ctl animated:YES];

}
@end
