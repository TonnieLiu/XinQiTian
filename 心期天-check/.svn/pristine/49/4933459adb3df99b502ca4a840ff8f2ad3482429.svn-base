//
//  FMDetailViewController.m
//  心期天
//
//  Created by qianfeng on 15/10/28.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import "FMDetailViewController.h"
#import "FMReplyCell.h"
#import "FMModel.h"
#import "FSAudioStream.h"
#import "ExploreViewController.h"

@interface FMDetailViewController ()
<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *lengthLabel;
@property (weak, nonatomic) IBOutlet UISlider *slider;

@property (weak, nonatomic) IBOutlet UIImageView *headerImagerView;
@property (weak, nonatomic) IBOutlet UILabel *nameBottomLabel;
@property (weak, nonatomic) IBOutlet UILabel *playNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *stonNumLabel;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (nonatomic,assign)NSInteger page;
@property (nonatomic,strong)NSMutableArray *replyArr;
@property (nonatomic,copy)NSString *fmurl;

@property (nonatomic,strong)FSAudioStream *audioStream;
@property (nonatomic,strong)NSTimer *myTimer;

@property (nonatomic,strong)FMModel *mode;
@end

@implementation FMDetailViewController
-(NSTimer *)myTimer{
    if (!_myTimer) {
        _myTimer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(updateSlider) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_myTimer forMode:NSRunLoopCommonModes];
    }
    return _myTimer;
}

-(FSAudioStream *)audioStream{
    if (!_audioStream) {
        _audioStream = [LJHttpManager audioStream];
        //[_audioStream playFromURL:];
        
    }
    return _audioStream;
    
}

-(NSMutableArray *)replyArr{
    if (!_replyArr) {
        _replyArr = [NSMutableArray new];
    }
    return _replyArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.page = 0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 50;
    [self requestData:NO];
}
- (void)requestData:(BOOL)flag{
    [LJHttpManager get:KFMDETAIL_URL parameters:@{@"fmid":[self.listMode.fmidlist[self.page] userId],@"fenleiid":self.listMode.userId} complement:^(id responseObject, NSError *error) {
        if (error) {
            NSLog(@"error = %@",error);
        } else {
            //NSLog(@"%@",responseObject);
            FMModel *mode = [[FMModel alloc] initWithDictionary:responseObject[@"data"] error:nil];
            self.mode = mode;
            [self updateHeaderView:mode];
            if ([self.fmurl isEqualToString:[LJHttpManager audioStreamPlayFromUrl:nil]]) {
                [self.myTimer fire];
                self.playButton.selected = self.audioStream.isPlaying;
            }
            if (flag) {
                [LJHttpManager audioStreamPlayFromUrl:self.fmurl];
                [self updateExploreView];
            }
            self.replyArr = mode.replylist;
            [self.tableView reloadData];
            //NSLog(@"test%@",mode.list.title);
        }
    }];
}
- (void)updateExploreView{
    ExploreViewController *ctl = (ExploreViewController *)[self.tabBarController.viewControllers[2] viewControllers][0];
    [ctl updateHeaderViewWithMode:self.mode];
}
- (void)updateHeaderView:(FMModel *)mode{
    self.titleLabel.text = [NSString stringWithFormat:@"情感FM--%@",mode.list.title];
    self.nameLabel.text = [NSString stringWithFormat:@"录音稿由心理咨询师:%@提供",mode.list.name];
    self.lengthLabel.text = mode.mp3length;
    self.nameBottomLabel.text = mode.list.name;
    self.playNumLabel.text = mode.list.playnum;
    self.stonNumLabel.text = mode.list.stonenum;
    self.headerImagerView.layer.cornerRadius = 35;
    [LJHttpManager setImageView:self.headerImagerView withUrl:mode.list.p_photo]; NSArray *arr = [mode.mp3length componentsSeparatedByString:@":"];
    self.slider.maximumValue = [arr[0] intValue] * 60 + [arr[1] intValue];
    self.fmurl = mode.list.fmurl;
    

}
#pragma mark-UITableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.replyArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FMReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FMReplyCell"];
    [cell refreshUI:self.replyArr[indexPath.item]];
    return cell;
}
#pragma mark- FM播放
- (IBAction)playAction:(UIButton *)sender {
    if ([self.fmurl isEqualToString:[LJHttpManager audioStreamPlayFromUrl:nil]]) {
        if (!self.audioStream.isPlaying) {
            [self.audioStream play];
        } else {
            [self.audioStream pause];
        }
    } else {
        [LJHttpManager audioStreamPlayFromUrl:self.fmurl];
        [self.myTimer fire];
        [self updateExploreView];
    }
    sender.selected = !sender.selected;
}
- (IBAction)sliderChange:(UISlider *)sender {
    FSStreamPosition position = {sender.value / 60 ,(int)sender.value % 60};
    [self.audioStream seekToPosition:position];
}
- (void)updateSlider{
    [self.slider setValue:(self.audioStream.currentTimePlayed.minute * 60 + self.audioStream.currentTimePlayed.second) animated:YES];
    self.currentTimeLabel.text = [NSString stringWithFormat:@"%d:%d",self.audioStream.currentTimePlayed.minute,self.audioStream.currentTimePlayed.second];
    self.playButton.selected = self.audioStream.isPlaying;
}
- (IBAction)nextFM:(UIButton *)sender {
    if (sender.tag == 11) {
        self.page --;
        if (self.page < 0) {
            self.page = self.listMode.fmidlist.count - 1;
        }
        
    } else {
        self.page ++;
        if (self.page >= self.listMode.fmidlist.count) {
            self.page = 0;
        }
    }
    [self requestData:self.playButton.selected];
}

@end
