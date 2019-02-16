//
//  PhoneNumViewController.m
//  YDElectricity
//
//  Created by 元典 on 2018/12/18.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import "PhoneNumViewController.h"
#import "Factory.h"
#import "VefifyRegisterViewModel.h"
#import "YDUserInfo.h"

#define kConfirmTeacherViewController @"ConfirmTeacherViewController"
#define kTimeIntervel 120

@interface PhoneNumViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTexfield;
@property (weak, nonatomic) IBOutlet UITextField *userCodeTexfield;
@property (weak, nonatomic) IBOutlet UITextField *verifyCodeTextfield;

@property (nonatomic,strong)VefifyRegisterViewModel *registerVM;


@property (weak, nonatomic) IBOutlet UIButton *verifyBtn;


@property (assign,nonatomic) NSInteger countDownInterverl;
@property (strong,nonatomic) NSTimer *timer;


//1.手机号输入框约束
//top约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *phoneNumTexfieldTopC;
//宽
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *phoneNumTexfieldWidthC;
//高
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *phoneNumTexfieldHeightC;
//2.密码输入框约束
//top
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userCodeTexfieldTopC;
//宽
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userCodeTexfieldWidthC;
//高
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userCodeTexfieldHeightC;

//验证码输入框约束
//top
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *verifyCodeTextfieldTopC;
//宽
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *verifyCodeTextfieldWidthC;
//高
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *verifyCodeTextfieldHeightC;

//获取验证码按钮约束
//training
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *VerifyBtnTrainningC;

//宽
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *VerifyBtnWidthC;
//高
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *VerifyBtnHeightC;

//下一步约束
//top
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *NextStepBtnTopC;
//宽
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *NextStepBtnWidthC;
//高
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *NextStepBtnHeightC;


@end

@implementation PhoneNumViewController

#pragma mark -- 懒加载
-(VefifyRegisterViewModel *)registerVM{
    if (!_registerVM) {
        _registerVM = [VefifyRegisterViewModel new];
    }
    return _registerVM;
}

#pragma mark -- 生命周期

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    //屏幕适配
    [self PhoneNumViewControllerScreenFit];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)setUpCountDownInterverl:(NSInteger) interverl{
    
    _countDownInterverl = interverl;
    if (_countDownInterverl!=0) {
        self.verifyBtn.enabled = NO;
        WK(weakSelf)
        self.timer = [NSTimer bk_scheduledTimerWithTimeInterval:1 block:^(NSTimer *timer) {
            weakSelf.countDownInterverl--;
//            NSLog(@"interverl%ld",weakSelf.countDownInterverl);
            [weakSelf.verifyBtn setTitle:[NSString stringWithFormat:@"%ldS",weakSelf.countDownInterverl] forState:UIControlStateNormal];
            if (weakSelf.countDownInterverl == 0) {
                [weakSelf destroyNSTimer];
                weakSelf.verifyBtn.enabled = YES;
                [weakSelf.verifyBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
            }
        } repeats:YES];
        
//        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
    }
}

-(void)timeFireMethod{
    self.countDownInterverl --;
    [self.verifyBtn setTitle:[NSString stringWithFormat:@"%ldS",self.countDownInterverl] forState:UIControlStateNormal];
    if(self.countDownInterverl ==0){
        [self.timer invalidate];
        [self.verifyBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    }
}


-(void)keyboardDidShow:(NSNotification *)notification
{
    //键盘打开;
}
-(void)keyboardDidHide:(NSNotification *)notification
{
    //键盘关闭
}



- (IBAction)OnVerifyBtnClick:(id)sender {
    NSLog(@"phoneNme:%@",self.phoneNumTexfield.text);
    //判断手机号码合法性
    if ([Factory isPhoneNumber:self.phoneNumTexfield.text]) {
        ////向服务器发送验证请求
        [self.registerVM getVefifyCodeWithParameter:self.phoneNumTexfield.text completionHandler:^(NSError * _Nonnull error) {
            if (!error) {
                [YDUserInfo sharedYDUserInfo].phoneNumber = self.phoneNumTexfield.text;
                [self.view showWarning:@"验证码已发送"];
                //倒计时两分钟
                [self setUpCountDownInterverl:kTimeIntervel];

            }
        }];
    }else{
        [self.view showWarning:@"手机号码不正确"];
    }
    
}


- (IBAction)OnNextStepBtnClick:(id)sender {
    [self destroyNSTimer];
    
    [YDUserInfo sharedYDUserInfo].userVerifyCode = self.verifyCodeTextfield.text;
    [YDUserInfo sharedYDUserInfo].phoneNumber = self.phoneNumTexfield.text;
    NSLog(@"手机号码:%@,验证码:%@",[YDUserInfo sharedYDUserInfo].phoneNumber,[YDUserInfo sharedYDUserInfo].userVerifyCode);
    //跳转到导师界面
    if ([YDUserInfo sharedYDUserInfo].phoneNumber.length == 0 && [YDUserInfo sharedYDUserInfo].userVerifyCode.length == 0) {
        [self.view showWarning:@"用户信息不正确"];
        return;
    }else{
       [self performSegueWithIdentifier:kConfirmTeacherViewController sender:nil];
    }
    
    
    
}


#pragma mark - UITextFieldDelegate 返回键
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [textField addTarget:self action:@selector(handlerTextFieldEndEdit:) forControlEvents:UIControlEventEditingDidEnd];
    return YES; // 当前 textField 可以编辑
}

#pragma mark - 处理编辑事件
- (void)handlerTextFieldEndEdit:(UITextField *)textField {
    NSLog(@"结束编辑:%@", textField.text);
    switch (textField.tag) {
        case 0:
        {
//            self.infoModel.nameStr = textField.text;
        }
            break;
        case 1:
        {
//            self.infoModel.phoneStr = textField.text;
        }
            break;
            
        case 2:
        {
            //            self.infoModel.phoneStr = textField.text;
        }
            break;
            
            
        default:
            break;
    }
}

#pragma mark - 处理点击事件
- (void)handlerTextFieldSelect:(UITextField *)textField {
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)dealloc{
    [self destroyNSTimer];
}

-(void)destroyNSTimer{
    [self.timer invalidate];
    self.timer = nil;
}


-(void)PhoneNumViewControllerScreenFit{
    [self phoneNumTexfieldScreenFit];
    [self userCodeTexfieldScreenFit];
//    [self verifyCodeTextfieldScreenFit];
    [self VerifyBtnScreenFit];
    [self NextStepBtnScreenFit];
}

-(void)phoneNumTexfieldScreenFit{
    self.phoneNumTexfieldTopC.constant *= kWidthScall;
    self.phoneNumTexfieldWidthC.constant *= kWidthScall;
    self.phoneNumTexfieldHeightC.constant *= kWidthScall;
}

-(void)userCodeTexfieldScreenFit{
    self.userCodeTexfieldTopC.constant *= kWidthScall;
    self.userCodeTexfieldWidthC.constant *= kWidthScall;
    self.userCodeTexfieldHeightC.constant *= kWidthScall;
}

-(void)verifyCodeTextfieldScreenFit{
    self.verifyCodeTextfieldTopC.constant *= kWidthScall;
    self.VerifyBtnWidthC.constant *= kWidthScall;
    self.VerifyBtnHeightC.constant *= kWidthScall;
}

-(void)VerifyBtnScreenFit{
    self.VerifyBtnTrainningC.constant *= kWidthScall;
    self.VerifyBtnWidthC.constant *= kWidthScall;
    self.VerifyBtnHeightC.constant *= kWidthScall;
}

-(void)NextStepBtnScreenFit{
    self.NextStepBtnTopC.constant *= kWidthScall;
    self.NextStepBtnWidthC.constant *= kWidthScall;
    self.NextStepBtnHeightC.constant *= kWidthScall;
}



@end
