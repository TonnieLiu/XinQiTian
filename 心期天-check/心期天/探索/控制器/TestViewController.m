//
//  TestViewController.m
//  心期天
//
//  Created by qianfeng on 15/11/4.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import "TestViewController.h"
#import "TestCell.h"
#import "TestModel.h"
#import "TitleLabel.h"
#import "ResultViewController.h"

@interface TestViewController ()
<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *clickNumLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,assign)NSInteger page;
@property (nonatomic,strong)NSMutableArray *testArr;
@property (nonatomic,assign)NSInteger mark;
@end

@implementation TestViewController
-(NSMutableArray *)testArr{
    if (!_testArr) {
        _testArr = [NSMutableArray new];
    }
    return _testArr;
}
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray new];
    }
    return _dataArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.page = 0;
    self.mark = 0;
    [self requestData];
}
#pragma mark-网络数据相关
- (void)requestData{
    NSLog(@"%@",self.typeId);
    [LJHttpManager get:KTEST_URL parameters:@{@"zyquiztypeid":self.typeId} complement:^(id responseObject, NSError *error) {
        if (error) {
            NSLog(@"error = %@",error);
        } else {
            //NSLog(@"%@",responseObject);
            for (NSDictionary *dict in responseObject[@"data"][@"list"]) {
                TestModel *mode = [[TestModel alloc] initWithDictionary:dict error:nil];
                [self.dataArr addObject:mode];
            }
            //[self.tableView reloadData];
            [self updateData];
            NSLog(@"%ld",self.dataArr.count);
        }
    }];
}
- (void)updateData{
    [self.testArr removeAllObjects];
    TestModel *mode = self.dataArr[self.page];
    
    if (mode.A.length) {
        TitleLabel *titleMode = [TitleLabel new];
        titleMode.content = mode.A;
        titleMode.mark = [mode.A1 integerValue];
        [self.testArr addObject:titleMode];
    }
    if (mode.B.length) {
        TitleLabel *titleMode = [TitleLabel new];
        titleMode.content = mode.B;
        titleMode.mark = [mode.B1 integerValue];
        [self.testArr addObject:titleMode];

    }
    if (mode.C.length) {
        TitleLabel *titleMode = [TitleLabel new];
        titleMode.content = mode.C;
        titleMode.mark = [mode.C1 integerValue];
        [self.testArr addObject:titleMode];

    }
    if (mode.D.length) {
        TitleLabel *titleMode = [TitleLabel new];
        titleMode.content = mode.D;
        titleMode.mark = [mode.D1 integerValue];
        [self.testArr addObject:titleMode];

    }
    
    self.titleLabel.text = [NSString stringWithFormat:@"%ld:%@",++self.page,mode.title];
    self.clickNumLabel.text = [NSString stringWithFormat:@"已有%@个人参加测试",mode.clicknum];
    [self.tableView reloadData];
    //self.page ++;
}
#pragma mark-UITableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TestCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TestCell"];
    [cell refreshUI:self.testArr[indexPath.row]];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.testArr.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.page < self.dataArr.count) {
        self.mark = self.mark + [self.testArr[indexPath.row] mark];
        [self updateData];
    } else {
        [self performSegueWithIdentifier:@"ResultSegue" sender:nil];
    }
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    ResultViewController *ctl = segue.destinationViewController;
    ctl.mark = self.mark;
    NSLog(@"%ld",self.mark);
}
@end
