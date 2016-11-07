//
//  PersonViewController.m
//  心期天
//
//  Created by qianfeng on 15/10/21.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import "PersonViewController.h"
#import "PersonCell.h"
#import "PersonCellModel.h"
#import "LoginViewController.h"
#import "UIButton+AFNetworking.h"
#import "InfoViewController.h"

@interface PersonViewController ()
<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headImage;


@property (nonatomic,strong)NSMutableArray *dataArr;
@end

@implementation PersonViewController
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray new];
    }
    return _dataArr;
}
#pragma mark-生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self requestData];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
#pragma mark-数据相关
- (void)requestData{
    self.headImage.layer.cornerRadius = 35;
    UITapGestureRecognizer *oneTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.headImage addGestureRecognizer:oneTap];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"PersonTableCell" ofType:@"plist"];
    NSArray *arr = [NSArray arrayWithContentsOfFile:path];
    for (NSArray *cellArr in arr) {
        NSMutableArray *mutArr = [NSMutableArray new];
        for (NSDictionary *dict in cellArr) {
            PersonCellModel *mode = [[PersonCellModel alloc] initWithDictionary:dict error:nil];
            [mutArr addObject:mode];
            
        }
        [self.dataArr addObject:mutArr];
    }
    NSString *infoPath = [NSHomeDirectory() stringByAppendingString:@"/infor.plist"];
    NSDictionary *infoDic = [NSDictionary dictionaryWithContentsOfFile:infoPath];
    NSLog(@"-->%@",infoPath);
    if ([[LJHttpManager userNum] length] == 0) {
        self.nameLabel.text = @"点击登录";
    } else {
        self.nameLabel.text = infoDic[@"name"];
    }
    [LJHttpManager setImageView:self.headImage withUrl:infoDic[@"photo"]];
}
#pragma mark-UITableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataArr[section] count];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KMainScreenWidth, 10)];
    imgView.image = [UIImage imageNamed:@"灰"];
    return imgView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PersonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonCell"];
    [cell refreshUI:self.dataArr[indexPath.section][indexPath.row]];
    return cell;
}
#pragma mark-点击事件
- (void)tapAction {
    if ([[LJHttpManager userNum] length] == 0) {
        [self performSegueWithIdentifier:@"LoginSegue" sender:nil];
    } else {
        [self performSegueWithIdentifier:@"InfoSegue" sender:nil];
    }
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.destinationViewController isKindOfClass:[LoginViewController class]]) {
        LoginViewController *ctl = segue.destinationViewController;
        ctl.block = ^(LoginModel *mode){
            self.nameLabel.text = mode.name;
            [LJHttpManager setImageView:self.headImage withUrl:mode.photo];
        };
    } else {
        InfoViewController *ctl = segue.destinationViewController;
        ctl.block = ^{
            self.nameLabel.text = @"";
            self.headImage.image = [UIImage imageNamed:@"头像_加载"];
        };
    }
}


@end
