//
//  FMListViewController.m
//  心期天
//
//  Created by qianfeng on 15/10/27.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import "FMListViewController.h"
#import "FMListCell.h"
#import "ThreeCell.h"
#import "FMDetailViewController.h"

@interface FMListViewController ()
<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong)NSMutableArray *threeArr;
@end

@implementation FMListViewController
-(NSMutableArray *)threeArr{
    if (!_threeArr) {
        _threeArr = [NSMutableArray new];
    }
    return _threeArr;
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
    [self updateDataArr];
}
- (void)updateDataArr{
    for (NSInteger i = 1; i < 4; i ++) {
        [self.threeArr addObject:self.dataArr[i]];
    }
    for (id obj in self.threeArr) {
        [self.dataArr removeObject:obj];
    }
    

    [self.dataArr insertObject:self.threeArr atIndex:1];
}
#pragma mark-UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.item == 1) {
        return CGSizeMake(KMainScreenWidth - 20, KMainScreenWidth - 20 - 100);
    } else {
        return CGSizeMake(KMainScreenWidth - 20, (KMainScreenWidth - 20) / 3);
    }
}
// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.item == 1) {
        ThreeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ThreeCell" forIndexPath:indexPath];
        [cell refreshUI:self.dataArr[indexPath.item]];
        cell.block = ^(NSInteger tag){
            FMDetailViewController *ctl = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"FMDetail"];
            ctl.listMode = self.dataArr[indexPath.item][tag];
            if (ctl.listMode.fmidlist.count != 0) {
                [self.navigationController pushViewController:ctl animated:YES];
            } else {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"当前分类没有频道" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
            }
            

        };
         return cell;
    } else {
        FMListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FMListCell" forIndexPath:indexPath];
        [cell refreshUI:self.dataArr[indexPath.item]];
        return cell;
    }
   
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.item != 1) {
        FMDetailViewController *ctl = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"FMDetail"];
        ctl.listMode = self.dataArr[indexPath.item];
        [self.navigationController pushViewController:ctl animated:YES];
    }
}

@end
