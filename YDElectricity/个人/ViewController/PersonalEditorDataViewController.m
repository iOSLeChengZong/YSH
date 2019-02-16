//
//  PersonalEditorDataViewController.m
//  YDElectricity
//
//  Created by 元典 on 2019/1/2.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import "PersonalEditorDataViewController.h"
#import <BRPickerView.h>
#import "UIAlertController+Blocks.h"
#import "YDNetManager.h"
#import "AddressManagerViewController.h"

#define kAddressManagerViewController @"AddressManagerViewController"



@interface PersonalEditorDataViewController ()<UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,AddressManagerViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UITextField *nickNameTexfield;//0
@property (weak, nonatomic) IBOutlet UITextField *birthdayTexfield;//1
@property (weak, nonatomic) IBOutlet UIButton *manBtn;
@property (weak, nonatomic) IBOutlet UIButton *womanBtn;

@property (weak, nonatomic) IBOutlet UITextField *areaTextField;//2
@property (weak, nonatomic) IBOutlet UITextField *finalTextField;//3
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;

@property (strong, nonatomic) UIAlertControllerCompletionBlock tapBlock;

@property (strong,nonatomic) UploadParam *pram;//上传图片

@property (nonatomic,strong)NSArray *genderBtns;

@property (nonatomic,assign)BOOL isMan;

@end

@implementation PersonalEditorDataViewController

#pragma mark -- 懒加载
-(UploadParam *)pram{
    if (!_pram) {
        _pram = [UploadParam new];
    }
    return _pram;
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
         WK(weakSelf)
        self.tapBlock = ^(UIAlertController *controller, UIAlertAction *action, NSInteger buttonIndex){
           
            if (buttonIndex == controller.destructiveButtonIndex) {
                NSLog(@"Delete");
            } else if (buttonIndex == controller.cancelButtonIndex) {
                NSLog(@"Cancel");
            } else if (buttonIndex >= controller.firstOtherButtonIndex) {
                NSInteger otherIndex = buttonIndex - controller.firstOtherButtonIndex + 1;
                NSLog(@"Other %ld", otherIndex);
                if (otherIndex == 1) {
                    //相机
                    NSLog(@"相机");
                    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                        UIImagePickerController *imagePicker = [UIImagePickerController new];
                        imagePicker.delegate = weakSelf;
                        imagePicker.editing = YES;
                        imagePicker.allowsEditing = YES;
                        
                        imagePicker.sourceType =  UIImagePickerControllerSourceTypeCamera;
                        imagePicker.modalPresentationStyle = UIModalPresentationFullScreen;
                        imagePicker.mediaTypes = @[(NSString *)kUTTypeImage];
                        imagePicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
                        [weakSelf presentViewController:imagePicker animated:YES completion:nil];
                    }
                    
                }else{
                    //相册
                    NSLog(@"相册");
                    UIImagePickerController *imagePicker = [UIImagePickerController new];
                    //创建UIImagePickerController对象，并设置代理和可编辑
                    imagePicker.delegate = weakSelf;
                    imagePicker.editing = YES;
                    imagePicker.allowsEditing = YES;
                    
                    //选择相册时，设置UIImagePickerController对象相关属性
                    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    
                    
                    
                    [weakSelf presentViewController:imagePicker animated:YES completion:nil];
                }
                
                
            }
        };
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    //从沙盒拿
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    
    [self.headImageView setImage:savedImage];
    //设置头像为圆角
    [self.headImageView viewcornerRadius:self.headImageView.bounds.size.width * 0.5 borderWith:0.02 clearColor:YES];
    
    //加载用户本地数据
    if ([self readUserCurrentInfo]) {
        NSDictionary *dic = [self readUserCurrentInfo];
        [self.headImageView setImage:[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@",dic[@"currentImage"]]]];
        //设置头像为圆角
        [self.headImageView viewcornerRadius:self.headImageView.bounds.size.width * 0.5 borderWith:0.02 clearColor:YES];
        self.nickNameTexfield.text = [NSString stringWithFormat:@"%@",dic[@"nickName"]];
        [self.nickNameTexfield setTextColor:kFONTSlectRGB];
        
        self.birthdayTexfield.text = [NSString stringWithFormat:@"%@",dic[@"birthDay"]];
        [self.birthdayTexfield setTextColor:kFONTSlectRGB];
        
        NSString *str = ([[NSString stringWithFormat:@"%@",dic[@"sex"]]  isEqual: @"1"]) ? @"y_p_choose1" : @"y_p_choose0";
        NSString *str1 = ([[NSString stringWithFormat:@"%@",dic[@"sex"]]  isEqual: @"2"]) ? @"y_p_choose1" : @"y_p_choose0";
        [self.manBtn setImage:[UIImage imageNamed:str] forState:UIControlStateNormal];
        [self.womanBtn setImage:[UIImage imageNamed:str1] forState:UIControlStateNormal];
        
//        self.areaTextField.text = [NSString stringWithFormat:@"%@",dic[@"area"]];
//        [self.areaTextField setTextColor:kFONTSlectRGB];
//
//        self.finalTextField.text = [NSString stringWithFormat:@"%@",dic[@"finalArea"]];
        [self.finalTextField setTextColor:kFONTSlectRGB];
        
        NSString *addr = [[NSUserDefaults standardUserDefaults] stringForKey:kDefauleAddr];
        if ([addr isEqualToString:@""]) {
            self.areaLabel.text = @"未选择";
            [self.areaLabel setTextColor:KFontDefaultRGB];
            self.finalTextField.text = @"未填写";
            [self.finalTextField setTextColor:KFontDefaultRGB];
        }else{
            NSArray *arr = [addr componentsSeparatedByString:@" "];
            if (arr.count > 0 && arr != nil) {
                self.areaLabel.text = arr[0];
                [self.areaLabel setTextColor:kFONTSlectRGB];
                self.finalTextField.text = arr[1];
                [self.finalTextField setTextColor:kFONTSlectRGB];
            }
            
        }
        
       

    }
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kViewBGColor;
    self.genderBtns = @[self.manBtn,self.womanBtn];

}

- (IBAction)editorVCBackBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)headImageTap:(id)sender {
    NSLog(@"头像被点面");

    [UIAlertController showActionSheetInViewController:self
                                             withTitle:@"请选择"
                                               message:nil
                                     cancelButtonTitle:@"取消"
                                destructiveButtonTitle:nil
                                     otherButtonTitles:@[@"相机", @"相册"]
#if TARGET_OS_IOS
                    popoverPresentationControllerBlock:^(UIPopoverPresentationController *popover){
                        
                        popover.sourceView = self.view;
                        popover.sourceRect = [sender view].frame;
                    }
#endif
                                              tapBlock:self.tapBlock];
    
    
}

- (IBAction)genderBtnClick:(id)sender {
    for (UIButton *btn in self.genderBtns) {
        if (btn == sender) {
            [btn setImage:[UIImage imageNamed:@"y_p_choose1"] forState:UIControlStateNormal];
            NSLog(@"btnTitle:%@",btn.currentTitle);
        }else{
           [btn setImage:[UIImage imageNamed:@"y_p_choose0"] forState:UIControlStateNormal];
        }
    }
    
    if (self.manBtn == sender) {
        self.isMan = true;
    }else{
        self.isMan = false;
    }
    
}




- (IBAction)saveBtnClick:(id)sender {
    
    NSLog(@"保存按钮被点击");
    [self.view showBusyHUD];
    NSDictionary *userInfDic = @{@"id":[[NSUserDefaults standardUserDefaults] stringForKey:kUserID],
                        @"nickName":self.nickNameTexfield.text,
                        @"birthDay":self.birthdayTexfield.text,
                        @"sex": self.isMan ? @"1": @"2",
                        @"area":[[self.areaLabel.text stringByAppendingString:@" "] stringByAppendingString:self.finalTextField.text],
                        @"shipAddressId":@"0"
                        };
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
    
    NSMutableDictionary *mdic = [userInfDic mutableCopy];
    [mdic setObject:fullPath forKey:@"currentImage"];
//    [mdic setObject:self.areaTextField.text forKey:@"area"];
//    [mdic setObject:self.finalTextField.text forKey:@"finalArea"];
    [mdic setObject:self.areaLabel.text forKey:@"address"];
    
    [self saveUserCurrentInfo:mdic];
    
    
    [YDNetManager uploadUserInfoPrameter:userInfDic completionHandler:^(VerifyRegisterModel * _Nonnull model, NSError * _Nonnull error) {
        NSLog(@"modelCode:%@",model.code);
        //查询用户身份
        
        [self.view hideBusyHUD];
    }];
    
}


#pragma mark - 获取地区数据源
- (NSArray *)getAddressDataSource {
    // 加载地区数据源（实际开发中这里可以写网络请求，从服务端请求数据。可以把 BRCity.json 文件的数据放到服务端去维护，通过接口获取这个数据源数组）
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"BRCity.json" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSArray *dataSource = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    return dataSource;
}

#pragma mark - UITextFieldDelegate 返回键
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.tag == 0 || textField.tag == 3) {
        [textField resignFirstResponder];
    }
    return YES;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField.tag == 0 || textField.tag == 3) {
        [textField addTarget:self action:@selector(handlerTextFieldEndEdit:) forControlEvents:UIControlEventEditingDidEnd];
        return YES; // 当前 textField 可以编辑
    } else {
        [self.view endEditing:YES];
        [self handlerTextFieldSelect:textField];
        return NO; // 当前 textField 不可编辑，可以响应点击事件
    }
}

#pragma mark - 处理编辑事件
- (void)handlerTextFieldEndEdit:(UITextField *)textField {
    NSLog(@"结束编辑:%@", textField.text);
    switch (textField.tag) {
        case 0:
        {
            [textField setTextColor:kFONTSlectRGB];
        }
            break;
        case 3:
        {
            [textField setTextColor:kFONTSlectRGB];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - 处理点击事件
- (void)handlerTextFieldSelect:(UITextField *)textField {
    
    if (textField.tag == 1) {
        NSDate *currentDate = [NSDate date];
        NSCalendar* calendar = [NSCalendar currentCalendar];
        NSDateComponents* components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth| NSCalendarUnitDay fromDate:currentDate]; // Get necessary date components
        
        NSDate *minDate = [NSDate br_setYear:1940 month:1 day:1];
        NSDate *maxDate = [NSDate br_setYear:[components year] - 16 month:[components month] day:[components day]];//
        NSLog(@"maxDate:%@",maxDate);
        [BRDatePickerView showDatePickerWithTitle:@"出生日期" dateType:BRDatePickerModeYMD defaultSelValue:textField.text minDate:minDate maxDate:maxDate isAutoSelect:YES themeColor:kFONTSlectRGB resultBlock:^(NSString *selectValue) {
            self.birthdayTexfield.text = selectValue;
            [self.birthdayTexfield setTextColor:kFONTSlectRGB];
        } cancelBlock:^{
            NSLog(@"点击了背景或取消按钮");
        }];
    }
}

#pragma mark -- UIImagePickerControllerDelegate
/** 选择图片的处理 */
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    //01.21 应该在提交成功后再保存到沙盒，下次进来直接去沙盒路径取
    
    // 保存图片至本地，方法见下文
    [self saveImage:image withName:@"currentImage.png"];
    //读取路径进行上传
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    
    [self.headImageView setImage:savedImage];//图片赋值显示
    
    //进到次方法时 调 UploadImage 方法上传服务端
    NSDictionary *dic = @{@"image":fullPath};
    [self UploadImage:dic];
    
}


#pragma mark - 保存图片至沙盒（应该是提交后再保存到沙盒,下次直接去沙盒取）
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    // 将图片写入文件
    
    [imageData writeToFile:fullPath atomically:NO];
}

#pragma mark -- AddressManagerViewControllerDelegate
-(void)fetchNewAddr:(NSString *)addrStr{
    NSArray *arr = [addrStr componentsSeparatedByString:@" "];
    if ([addrStr isEqualToString:@""]) {
        self.areaLabel.text = @"未选择";
        [self.areaLabel setTextColor:KFontDefaultRGB];
        self.finalTextField.text = @"未填写";
        [self.finalTextField setTextColor:KFontDefaultRGB];
    }else{
        if (arr.count > 0 && arr != nil) {
            self.areaLabel.text = arr[0];
            [self.areaLabel setTextColor:kFONTSlectRGB];
            self.finalTextField.text = arr[1];
            [self.finalTextField setTextColor:kFONTSlectRGB];
        }
        
        
    }
    
}


//头像上传
-(void)UploadImage:(NSDictionary *)type
{
    
    NSString * imgpath = [NSString stringWithFormat:@"%@",type[@"image"]];
    UIImage *image = [UIImage imageWithContentsOfFile:imgpath];
    NSData *data = UIImageJPEGRepresentation(image,0.7);
    
    self.pram.data = data;
    self.pram.name = @"file";
    self.pram.filename = @"currentImage.png";
    self.pram.mimeType = @"png/jpeg";
    
    [self.view showBusyHUD];
    [YDNetManager uploadHeaderImageWithUploadParam:@[self.pram] completionHandler:^(VerifyRegisterModel * _Nonnull model, NSError * _Nonnull error) {
        NSLog(@"modeCode:%@",model.code);
        [self.view hideBusyHUD];
        [self.view showWarning:@"用户信息保存成功"];
    }];
    
    
}

//保存用户当前数据
-(void)saveUserCurrentInfo:(NSMutableDictionary *) currentInfo{
    
    NSUserDefaults *defaulet = [NSUserDefaults standardUserDefaults];
    [defaulet setObject:currentInfo forKey:kUserCurrentInfo];
    [defaulet setObject:[[self.areaLabel.text stringByAppendingString:@" "] stringByAppendingString:self.finalTextField.text] forKey:kDefauleAddr];
    [defaulet synchronize];
}

//加载用户本地数据
-(NSDictionary *)readUserCurrentInfo{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return (NSDictionary *)[userDefaults objectForKey:kUserCurrentInfo];
    
}


- (IBAction)areaLabelTap:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kYDPersonal bundle:nil];
    AddressManagerViewController *avc = [storyboard instantiateViewControllerWithIdentifier:kAddressManagerViewController];
    avc.delegate = self;
    [self.navigationController pushViewController:avc animated:YES];
    
    
}



@end
