//
//  InfoViewController.m
//  心期天
//
//  Created by qianfeng on 15/10/31.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import "InfoViewController.h"
#import "ProvinceModel.h"

@interface InfoViewController ()
<UIPickerViewDataSource,UIPickerViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sexSegmented;
@property (weak, nonatomic) IBOutlet UILabel *birthdayLabel;
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;
@property (weak, nonatomic) IBOutlet UIPickerView *pickView;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *telLabel;

@property (nonatomic,strong)NSArray *provinceArr;
@property (nonatomic,strong)NSArray *cityArr;
@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,strong)NSDictionary *pro_cityDict;
@property (nonatomic,assign)BOOL pickType;
//@property (nonatomic,assign)NSInteger imageType;
@end

@implementation InfoViewController
-(NSDictionary *)pro_cityDict{
    if (!_pro_cityDict) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"cityData" ofType:@"plist"];
         _pro_cityDict = [NSDictionary dictionaryWithContentsOfFile:path];
    }
    return _pro_cityDict;
}
-(NSArray *)provinceArr{
    if (!_provinceArr) {
        _provinceArr = [NSArray new];
        //_provinceArr = [[self addCityArr] allKeys];
    }
    return _provinceArr;
}
-(NSArray *)cityArr{
    if (!_cityArr) {
        _cityArr = [NSArray new];
    }
    return _cityArr;
}
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray new];
        [self addTimeInfoWithArr:_dataArr];
    }
    return _dataArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadDatabase];
    [self initCityArr];
}
#pragma mark-本地数据
- (void)loadDatabase{
    [self.headerImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTap:)]];
    self.headerImage.userInteractionEnabled = YES;
    NSString *path = [NSHomeDirectory() stringByAppendingString:@"/infor.plist"];
    NSDictionary *infoDict = [NSDictionary dictionaryWithContentsOfFile:path];
    self.cityLabel.text = infoDict[@"birthplace"];
    self.sexSegmented.selectedSegmentIndex = [infoDict[@"sex"] intValue];
    self.nameTextField.text = infoDict[@"name"];
    [LJHttpManager setImageView:self.headerImage withUrl:infoDict[@"photo"]];
    self.birthdayLabel.text = infoDict[@"birthday"];
    self.telLabel.text = infoDict[@"tel"];
}
#pragma mark-城市信息
- (void)initCityArr{
    self.provinceArr = [self.pro_cityDict allKeys];
    NSInteger selectedProvinceIndex = [self.pickView selectedRowInComponent:0];
    NSString *seletedProvince = [self.provinceArr objectAtIndex:selectedProvinceIndex];
    self.cityArr = [self.pro_cityDict objectForKey:seletedProvince];
}
- (void)addTimeInfoWithArr:(NSMutableArray *)mutArr{
    NSMutableArray *yearArr = [NSMutableArray new];
    NSMutableArray *monthArr = [NSMutableArray new];
    NSMutableArray *dayArr = [NSMutableArray new];
    for (NSInteger i = 2015; i >= 1970; i --) {
        [yearArr addObject:[NSString stringWithFormat:@"%ld",i]];
    }
    for (NSInteger i = 1; i <= 12; i ++) {
        [monthArr addObject:[NSString stringWithFormat:@"%ld",i]];
    }
    for (NSInteger i = 1; i <= 31; i ++) {
        [dayArr addObject:[NSString stringWithFormat:@"%ld",i]];
    }
    [mutArr addObject:yearArr];
    [mutArr addObject:monthArr];
    [mutArr addObject:dayArr];
}
#pragma mark-点击事件
- (void)photoTap:(UIGestureRecognizer *)ges{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"选择图片" delegate:self cancelButtonTitle:@"取消"destructiveButtonTitle:nil otherButtonTitles:@"照相机",@"图库", nil];
    [sheet showInView:self.view];
    
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex != 2) {
        UIImagePickerController *pickCtl = [UIImagePickerController new];
        BOOL isCamera = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
        NSLog(@"是否支持相机:%d",isCamera);
        if (buttonIndex == 0) {
            if (!isCamera) {
                [LJHttpManager alertViewFromTaget:self withMessage:@"不支持照相功能"];
                return;
            }
            pickCtl.sourceType = UIImagePickerControllerSourceTypeCamera;
        } else if (buttonIndex == 1) {
            pickCtl.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        pickCtl.allowsEditing = YES;
        pickCtl.delegate = self;
        [self presentViewController:pickCtl animated:YES completion:nil];
    }
    
    
//    self.imageType = buttonIndex;
//    UIImagePickerController *pickCtl = [UIImagePickerController new];
//    if (self.imageType == 1) {
//        pickCtl.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//        
//    } else if (self.imageType == 0) {
//        pickCtl.sourceType = UIImagePickerControllerSourceTypeCamera;
//    }
//    pickCtl.allowsEditing = YES;
//    pickCtl.delegate = self;
//    if (self.imageType != 2) {
//        [self presentViewController:pickCtl animated:YES completion:nil];
//    }

}
- (IBAction)changeAction:(UIButton *)sender {
    if (sender.tag == 100) {
        self.pickType = YES;
    } else {
        self.pickType = NO;
    }
    self.doneBtn.hidden = NO;
    self.pickView.hidden = NO;
    [UIView animateWithDuration:0.25f animations:^{
        self.doneBtn.alpha = 1;
        self.pickView.alpha = 1;
    }];
    [self.pickView reloadAllComponents];
}
- (IBAction)updateInfoAction:(UIButton *)sender {
    [LJHttpManager post:KINFO_URL parameters:@{@"user_sex":[NSString stringWithFormat:@"%ld",self.sexSegmented.selectedSegmentIndex + 1],@"birthday":self.birthdayLabel.text,@"user_id":[LJHttpManager userNum],@"name":self.nameTextField.text,@"user_phone":self.telLabel.text} complement:^(id responseObject, NSError *error) {
        if (error) {
            NSLog(@"error = %@",error);
        } else {
            NSLog(@"%@",responseObject);
            if ([responseObject[@"code"] isEqualToString:@"1"]) {
                NSString *path = [NSHomeDirectory() stringByAppendingString:@"/infor.plist"];
                NSMutableDictionary *infoDict = [NSMutableDictionary dictionaryWithContentsOfFile:path];
                [infoDict setObject:[NSString stringWithFormat:@"%ld",self.sexSegmented.selectedSegmentIndex] forKey:@"user_sex"];
                [infoDict setObject:self.birthdayLabel.text forKey:@"birthday"];
                [infoDict setObject:self.telLabel.text forKey:@"user_phone"];
                [infoDict setObject:self.cityLabel.text forKey:@"birthplace"];
                [infoDict writeToFile:path atomically:YES];
            }
        }
    }];
}
- (IBAction)doneAction:(id)sender {
    if (self.pickType) {
        NSInteger year = [self.pickView selectedRowInComponent:0];
        NSInteger month = [self.pickView selectedRowInComponent:1];
        NSInteger day = [self.pickView selectedRowInComponent:2];
        self.birthdayLabel.text = [NSString stringWithFormat:@"%@-%@-%@",self.dataArr[0][year],self.dataArr[1][month],self.dataArr[2][day]];
    } else {
        NSInteger pro = [self.pickView selectedRowInComponent:0];
        NSInteger city = [self.pickView selectedRowInComponent:1];
        self.cityLabel.text = [NSString stringWithFormat:@"%@%@",self.provinceArr[pro],self.cityArr[city]];
    }
    
    [UIView animateWithDuration:0.25f animations:^{
        self.doneBtn.alpha = 0;
        self.pickView.alpha = 0;
    } completion:^(BOOL finished) {
        self.doneBtn.hidden = YES;
        self.pickView.hidden = YES;
    }];
    
}
#pragma mark-UIPickViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    if (self.pickType) {
       return self.dataArr.count;
    } else {
        return 2;
    }
}
// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (self.pickType) {
        return [self.dataArr[component] count];
    } else {
        if (component == 0) {
            return self.provinceArr.count;
        } else {
            return self.cityArr.count;
        }
    }
    
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (self.pickType) {
        return self.dataArr[component][row];
    } else {
        if (component == 0) {
            return self.provinceArr[row];
        } else {
            return self.cityArr[row];
        }
    }
    
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {
        NSString *province = self.provinceArr[row];
        self.cityArr = [self.pro_cityDict objectForKey:province];
        [self.pickView reloadComponent:1];
    }
}
- (IBAction)deallocAction:(id)sender {
    NSString *path = [NSHomeDirectory() stringByAppendingString:@"/infor.plist"];
    
    //NSLog(@"path = %@",path);
    NSFileManager *fm = [NSFileManager defaultManager];
    [fm removeItemAtPath:path error:nil];
    self.block();
    [self.navigationController popToRootViewControllerAnimated:YES];
}
#pragma mark-相册
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    self.headerImage.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:KINFO_URL]];
    request.HTTPMethod = @"POST";
    [request addValue:@"multipart/form-data;boundary=L2eaCMvM7rDw5xoX3cvQFYSgkJCGtP"  forHTTPHeaderField:@"Content-Type"];
    NSMutableData *bodyData = [NSMutableData new];
    [bodyData appendData:[@"--L2eaCMvM7rDw5xoX3cvQFYSgkJCGtP\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [bodyData appendData:[@"Content-Disposition: form-data; name=\"photo\"; filename=\"temp.jpg\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [bodyData appendData:[@"Content-Type: application/octet-stream\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [bodyData appendData:[@"Content-Transfer-Encoding: binary\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [bodyData appendData:UIImageJPEGRepresentation([info objectForKey:UIImagePickerControllerOriginalImage], 0.1)];
    [bodyData appendData:[@"\r\n--L2eaCMvM7rDw5xoX3cvQFYSgkJCGtP--\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    request.HTTPBody = bodyData;
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSLog(@"%@",[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil]);
    }];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
