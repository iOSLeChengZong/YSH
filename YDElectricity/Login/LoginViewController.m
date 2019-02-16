//
//  LoginViewController.m
//  YDElectricity
//
//  Created by 元典 on 2018/12/18.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import "LoginViewController.h"
#import "VefifyRegisterViewModel.h"
#import "YDUserInfo.h"


@interface LoginViewController ()
@property(nonatomic,strong)VefifyRegisterViewModel *registerViewModel;
@property(nonatomic,strong)NSString *userWxID;
@property(nonatomic,strong)NSString *userPhonNum;

//1.App标识约束
//宽
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *productIdentifierImageWidthC;
//高
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *productIdentifierImageHeightC;

//bottom
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *productIdentifierImageBottomC;

//2.微信登陆约束
//宽
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *weiChatBtnWidthC;

//高
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *weiChatBtnHeightC;

//bottom
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *weiChatBtnBottomC;

//3.游客模式约束
//宽
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *visitorBtnWidthC;

//高
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *visitorBtnHeightC;

//bottom
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *visitorBtnBottomc;

@end

@implementation LoginViewController

#pragma mark -- 懒加载
-(VefifyRegisterViewModel *)registerViewModel{
    if (!_registerViewModel) {
        _registerViewModel = [VefifyRegisterViewModel new];
    }
    return _registerViewModel;
}

#pragma mark -- 生命周期
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    //屏幕适配
    [self LoginViewControllerScreenFit];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //获取用户数据
    [self readNSUserDefaults];
    
    
//    //将上述数据全部存储到NSUserDefaults中
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//
//    [userDefaults setObject:@"" forKey:kUserWxOpenID];
//    [userDefaults setObject:@"" forKey:kUserPhoneNum];
//
//    //这里建议同步存储到磁盘中，但是不是必须的
//    [userDefaults synchronize];
    
}

//微信登陆
- (IBAction)OnWeChatBtnClick:(id)sender {
    //本地查询微信返回的userid 和token
    //如果没有,请求微信授权
    
    
    [self requestRegisterState:sender];
    
}




//游客登陆  游客登陆条件:首次登陆,退出登陆,注销账号
- (IBAction)OnVisitorBtnClick:(id)sender {
    [YDUserInfo sharedYDUserInfo].login = NO;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kMain bundle:nil];
    UITabBarController *tabVC = [storyboard instantiateViewControllerWithIdentifier:kMain];
    [[[UIApplication sharedApplication] delegate] window].rootViewController = tabVC;
    
    
}


-(void)requestRegisterState:(id)sender{
    WK(weakSelf)
    if (self.userWxID.length > 0 || self.userPhonNum.length > 0) {//本地保存了WxID直接请求登陆
        [self.registerViewModel requestLoginWithParameter:self.userWxID phoneNum:self.userPhonNum completionHandler:^(NSError * _Nonnull error) {
            if (!error) {
                //保存数据
                [YDUserInfo sharedYDUserInfo].userWxOpenID = weakSelf.registerViewModel.wxOpenID;
                [YDUserInfo sharedYDUserInfo].phoneNumber = weakSelf.registerViewModel.phoneNum;
                [self saveNSUserDefaults];
//                [weakSelf OnVisitorBtnClick:sender];
                //请求登陆
                [self requestLogin];
                
            }
        }];
        
    }else{
        [self.registerViewModel getUserRegisterStateWithParameter:[self timeStr]/*@"fd56fd126d7eae0e41f74c895394155e"*/ completionHandler:^(NSError * _Nonnull error) {
            if (!error) {
                if ([weakSelf.registerViewModel.codeState isEqualToString:@"3"]) {//用户不存在
                    NSLog(@"跳填写号码界面%@",weakSelf.registerViewModel.codeState);
                    [YDUserInfo sharedYDUserInfo].login = NO;
                    [YDUserInfo sharedYDUserInfo].userWxOpenID = [self timeStr]/*@"fd56fd126d7eae0e41f74c895394155e"*/;
        
                    [self performSegueWithIdentifier:kPhoneNumSegue sender:nil];
                }
                else if ([weakSelf.registerViewModel.codeState isEqualToString:@"2"]) {//用户已存在直接调用登陆接口
                    [YDUserInfo sharedYDUserInfo].login = NO;
                    [YDUserInfo sharedYDUserInfo].userWxOpenID = [self.registerViewModel wxOpenID]/*@"fd56fd126d7eae0e41f74c895394155e"*/;
                    //请求登陆
                    [self requestLogin];
                    
                    
                }
                else{
                    [self.view showWarning:@"验证微信号失败"];
                }
                
            }
        }];
  
    }
}


/** 保存用户微信号 和 手机号吗*/
-(void)saveNSUserDefaults
{
    //将上述数据全部存储到NSUserDefaults中
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:[YDUserInfo sharedYDUserInfo].userWxOpenID forKey:kUserWxOpenID];
    [userDefaults setObject:[YDUserInfo sharedYDUserInfo].phoneNumber forKey:kUserPhoneNum];
    [userDefaults setObject:[YDUserInfo sharedYDUserInfo].userToken  forKey:kUserToken];
    [userDefaults setObject:[YDUserInfo sharedYDUserInfo].userID forKey:kUserID];
    
    //这里建议同步存储到磁盘中，但是不是必须的
    [userDefaults synchronize];
    
    
}



//从NSUserDefaults中读取数据
-(void)readNSUserDefaults
{
    self.userWxID = [[NSUserDefaults standardUserDefaults] stringForKey:kUserWxOpenID];
    self.userPhonNum = [[NSUserDefaults standardUserDefaults] stringForKey:kUserPhoneNum];
    NSLog(@"%@:phoneNumber:%@",[self class],self.userWxID);
    NSLog(@"%@:wxid:%@",[self class],self.userPhonNum);
}

-(void)requestLogin{
    [[YDUserInfo sharedYDUserInfo] requestLoginCompletionHandler:^(VerifyRegisterModel * _Nonnull model, NSError * _Nonnull error) {
        if (!error && [model.code isEqualToString:@"1"]){
            //保存token 保存 id
            [YDUserInfo sharedYDUserInfo].userToken = model.rows1.token;
            [YDUserInfo sharedYDUserInfo].userID = model.rows1.userInfo.ID;
            [self saveNSUserDefaults];
            [self.view showWarning:@"登陆成功"];
            [YDUserInfo sharedYDUserInfo].login = YES;
            [self saveNSUserDefaults];
            //跳转界面;
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UITabBarController *tabVC = [storyboard instantiateViewControllerWithIdentifier:kMain];
            [[[UIApplication sharedApplication] delegate] window].rootViewController = tabVC;
        }else{
            [self.view showWarning:@"请检查手机号码或微信号不存在"];
        }
    }];
}

-(NSString *)timeStr{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [formatter stringFromDate: [NSDate date]];
}


//屏幕适配
-(void)LoginViewControllerScreenFit{
    [self visitorBtnBottomc];
    [self weiChatBtnScreenFit];
    [self productIdentifierImageScreenFit];
}

//1.游客模式
-(void)visitorBtnScreenFit{
    self.visitorBtnWidthC.constant *= kWidthScall;
    self.visitorBtnHeightC.constant *= kWidthScall;
    self.visitorBtnBottomc.constant *= kWidthScall;
}

//2.微信登陆
-(void)weiChatBtnScreenFit{
    self.weiChatBtnWidthC.constant *= kWidthScall;
    self.weiChatBtnHeightC.constant *= kWidthScall;
    self.weiChatBtnBottomC.constant *= kWidthScall;
}

//3.产品标识
-(void)productIdentifierImageScreenFit{
    self.productIdentifierImageWidthC.constant *= kWidthScall;
    self.productIdentifierImageHeightC.constant *= kWidthScall;
    self.productIdentifierImageBottomC.constant *= kWidthScall;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
