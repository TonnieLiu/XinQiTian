//
//  HomeViewController.m
//  心期天
//
//  Created by qianfeng on 15/10/21.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeTableViewCell.h"
#import "HotProblemCell.h"
#import "RollPhotoModel.h"
#import "ZiXunModel.h"
#import "HotProblemModel.h"
#import "MJRefresh.h"
#import "ActivityViewController.h"
#import "ZiXunModel.h"
#import "HotProblemModel.h"
#import "DetailViewController.h"
#import "PhotoViewController.h"
#import "AFNetworking.h"
#import "ZJViewController.h"

@interface HomeViewController ()
<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic,strong)NSMutableArray *photoArr;
@property (nonatomic,strong)NSMutableArray *zixunArr;
@property (nonatomic,strong)NSMutableArray *pbmArr;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *width;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;
@end

@implementation HomeViewController
-(NSMutableArray *)pbmArr{
    if (!_pbmArr) {
        _pbmArr = [NSMutableArray new];
    }
    return _pbmArr;
}
-(NSMutableArray *)zixunArr{
    if (!_zixunArr) {
        _zixunArr = [NSMutableArray new];
    }
    return _zixunArr;
}
-(NSMutableArray *)photoArr{
    if (!_photoArr) {
        _photoArr = [NSMutableArray new];
    }
    return _photoArr;
}
#pragma mark-生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    //self.tableView.rowHeight = UITableViewAutomaticDimension;
    //self.automaticallyAdjustsScrollViewInsets = NO;
    [self refreshUI];
    [self netWorkStatus];
}
-(void)netWorkStatus{
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status !=  AFNetworkReachabilityStatusNotReachable) {
            
            [self requestData];
            [self createRefresh];
        }else {
            
            NSLog(@"无网络");
            
        }
        
        
    }];
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requestData];
        [self createRefresh];
    }];
}

#pragma mark-网络数据相关
- (void)requestData{
    [LJHttpManager get:KCONDIS_URL parameters:nil complement:^(id responseObject, NSError *error) {
        if (error) {
            NSLog(@"error = %@",error);
        } else {
            if (self.tableView.header.isRefreshing) {
                //[self.pbmArr removeAllObjects];
                [self.zixunArr removeAllObjects];
            }
            for (NSDictionary *dict in responseObject[@"zixunshi"]) {
                ZiXunModel *mode = [[ZiXunModel alloc] initWithDictionary:dict error:nil];
                [self.zixunArr addObject:mode];
            }
            //[self.tableView.header endRefreshing];
            [LJHttpManager get:KHOTPREBLEM_URL parameters:nil complement:^(id responseObject, NSError *error) {
                if (error) {
                    NSLog(@"error = %@",error);
                } else {
                    if (self.tableView.header.isRefreshing) {
                        [self.pbmArr removeAllObjects];
                        //[self.zixunArr removeAllObjects];
                    }
                    for (NSDictionary *dict in responseObject[@"data"]) {
                        HotProblemModel *mode = [[HotProblemModel alloc] initWithDictionary:dict error:nil];
                        [self.pbmArr addObject:mode];
                    }
                    [self.tableView.header endRefreshing];
                    [self.tableView reloadData];
                }
            }];
            //[self.tableView reloadData];
        }
    }];
    
}
#pragma mark-上拉刷新
- (void)createRefresh{

    [LJHttpManager get:KROLLPHOTO_URL parameters:nil complement:^(id responseObject, NSError *error) {
        if (error) {
            NSLog(@"error = %@",error);
        } else {
            //NSLog(@"%@",responseObject);
            if (self.tableView.header.isRefreshing) {
                [self.photoArr removeAllObjects];
            }
            for (NSDictionary *dict in responseObject[@"data"]) {
                RollPhotoModel *photoMode = [[RollPhotoModel alloc] initWithDictionary:dict error:nil];
                [self.photoArr addObject:photoMode];
            }
            //[view refreshUI:self.photoArr];
            [self updatePhoto];
        }
    }];
    //self.tableView.tableHeaderView = view;
}
#pragma mark-头部视图
-(void)refreshUI{
    self.width.constant = KMainScreenWidth * 3;
    self.height.constant = 160;
    for (NSInteger i = 0;i < 3;i ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(KMainScreenWidth *i, 0, KMainScreenWidth, 160)];
        //[LJHttpManager setImageView:imageView withUrl:mode.photo];
        imageView.image = [UIImage imageNamed:@"加载图"];
        [self.contentView addSubview:imageView];
        imageView.tag = 10 + i;
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [imageView addGestureRecognizer:tapGes];
        imageView.userInteractionEnabled = YES;
    }
    self.scrollView.contentOffset = CGPointMake(KMainScreenWidth, 0);
    [[NSRunLoop currentRunLoop] addTimer:[NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(changePhoto) userInfo:nil repeats:YES] forMode:NSRunLoopCommonModes];
}
- (void)changePhoto{
    [self.scrollView setContentOffset:CGPointMake(KMainScreenWidth * 2, 0) animated:YES];
}
- (void)tapAction:(UIGestureRecognizer *)ges{
    RollPhotoModel *mode = self.photoArr[ges.view.tag - 10];
    if ([mode.type isEqualToString:@"2"]) {
        ActivityViewController *ctl = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ActivityViewController"];
        ctl.activityId = mode.linkid;
        [self.navigationController pushViewController:ctl animated:YES];
    } else {
        PhotoViewController *ctl = [[PhotoViewController alloc] init];
        //ctl.title = @"个人成长";
        ctl.essayid = mode.linkid;
        [self.navigationController pushViewController:ctl animated:YES];
    }

}
- (void)updatePhoto{
    for (NSInteger i = 0; i < self.photoArr.count; i ++) {
        UIImageView *imageView = (UIImageView *)[self.contentView viewWithTag:i + 10];
        [LJHttpManager setImageView:imageView withUrl:[self.photoArr[i] photo]];
    }
}
#pragma mark-UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.photoArr.count >= 3) {
        if (self.scrollView.contentOffset.x <= 0) {
            id obj = [self.photoArr lastObject];
            [self.photoArr insertObject:obj atIndex:0];
            [self.photoArr removeLastObject];
            self.scrollView.contentOffset = CGPointMake(KMainScreenWidth, 0);
            [self updatePhoto];
        } else if (self.scrollView.contentOffset.x >= KMainScreenWidth * 2) {
            id obj = self.photoArr[0];
            [self.photoArr addObject:obj];
            [self.photoArr removeObjectAtIndex:0];
            self.scrollView.contentOffset = CGPointMake(KMainScreenWidth, 0);
            [self updatePhoto];
        }

    }
}

#pragma mark-UITableView代理方法
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return @"热门问题";
    } else {
        return nil;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    } else {
        return self.pbmArr.count;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 135;
    } else {
        return 80;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeTableViewCell"];
        cell.block = ^(NSString *userId){
            [self performSegueWithIdentifier:@"ZJSegue" sender:userId];
        };
        [cell refreshUI:self.zixunArr];
        return cell;
    } else {
        HotProblemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HotProblemCell"];
        [cell refreshUI:self.pbmArr[indexPath.row]];
        return cell;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        DetailViewController *ctl = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"Detail"];
        ctl.title = @"详情";
        HotProblemModel *mode = self.pbmArr[indexPath.row];
        ctl.userId = mode.userId;
        [self.navigationController pushViewController:ctl animated:YES];
    }
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(@"sender = %@",sender);
    ZJViewController *ctl = segue.destinationViewController;
    ctl.userId = sender;
}


@end
