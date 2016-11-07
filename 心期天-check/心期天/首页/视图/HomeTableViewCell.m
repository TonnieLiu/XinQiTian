//
//  HomeTableViewCell.m
//  心期天
//
//  Created by qianfeng on 15/10/23.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import "HomeTableViewCell.h"
#import "CondisPlayCell.h"

@interface HomeTableViewCell ()
<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong)NSMutableArray *dataArr;
@end

@implementation HomeTableViewCell
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray new];
    }
    return _dataArr;
}
- (void)awakeFromNib {
    // Initialization code
}
-(void)refreshUI:(NSArray *)arr{
    self.dataArr = [arr  mutableCopy];
    [self.collectionView reloadData];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark-UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CondisPlayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CondisPlayCell" forIndexPath:indexPath];
    if (self.dataArr.count != 0) {
        [cell refreshUI:self.dataArr[indexPath.item]];
    }
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.block([self.dataArr[indexPath.item] userId]);
}

@end
