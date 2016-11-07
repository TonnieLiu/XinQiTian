//
//  NuanWoViewController.m
//  心期天
//
//  Created by qianfeng on 15/10/21.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import "NuanWoViewController.h"
#import "NuanWoModel.h"
#import "NuanWoTableViewCell.h"
#import "MJRefresh.h"
#import "DetailViewController.h"
#import "XQViewController.h"

@interface NuanWoViewController ()
<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,assign)NSInteger page;
@end

@implementation NuanWoViewController
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray new];
    }
    return _dataArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 160;
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
    [LJHttpManager get:KNUANWO_URL parameters:@{@"page":[NSString stringWithFormat:@"%ld",self.page],@"userid":[LJHttpManager userNum],@"usertype":@"1"} complement:^(id responseObject, NSError *error) {
        //NSLog(@"%@",responseObject);
        if (error) {
            NSLog(@"error = %@",error);
        } else {
            if (self.tableView.header.isRefreshing) {
                [self.dataArr removeAllObjects];
            }
            //NSLog(@"%@",responseObject[@"woliaolist"]);
            for (NSDictionary *dict in responseObject[@"woliaolist"]) {
                NuanWoModel *mode = [[NuanWoModel alloc] initWithDictionary:dict error:nil];
                [self.dataArr addObject:mode];
            }
            [self.tableView reloadData];
            [self.tableView.header endRefreshing];
            [self.tableView.footer endRefreshing];
        }
    }];
}
#pragma mark-UITableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NuanWoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NuanWoCell"];
    [cell refreshUI:self.dataArr[indexPath.row]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *ctl = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"Detail"];
    ctl.title = @"详情";
    NuanWoModel *mode = self.dataArr[indexPath.row];
    ctl.userId = mode.userId;
    [self.navigationController pushViewController:ctl animated:YES];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.destinationViewController isKindOfClass:[XQViewController class]]) {
        XQViewController *ctl = segue.destinationViewController;
        ctl.block = ^{
            self.page = 1;
            [self.dataArr removeAllObjects];
            [self requestData];
        };
    }
}
@end
