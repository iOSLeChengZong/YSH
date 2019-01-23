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
@end

@implementation LoginViewController

#pragma mark -- 懒加载
-(VefifyRegisterViewModel *)registerViewModel{
    if (!_registerViewModel) {
        _registerViewModel = [VefifyRegisterViewModel new];
    }
    return _registerViewModel;
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
    if (self.userWxID.length > 0 && self.userPhonNum.length > 0) {
        [self.registerViewModel requestLoginWithParameter:self.userWxID phoneNum:self.userPhonNum completionHandler:^(NSError * _Nonnull error) {
            if (!error) {
                //保存数据
                [YDUserInfo sharedYDUserInfo].userWxOpenID = weakSelf.registerViewModel.wxOpenID;
                [YDUserInfo sharedYDUserInfo].phoneNumber = weakSelf.registerViewModel.phoneNum;
                [self saveNSUserDefaults];
                [weakSelf OnVisitorBtnClick:sender];
            }
        }];
        
    }else{
        [self.registerViewModel getUserRegisterStateWithParameter:@"fd56fd126d7eae0e41f74c895394155e" completionHandler:^(NSError * _Nonnull error) {
            if (!error) {
                if ([weakSelf.registerViewModel.codeState isEqualToString:@"3"]) {//用户不存在
                    NSLog(@"跳  填写号码界面%@",weakSelf.registerViewModel.codeState);
                    [YDUserInfo sharedYDUserInfo].login = NO;
                    [YDUserInfo sharedYDUserInfo].userWxOpenID = @"fd56fd126d7eae0e41f74c895394155e";
                    [self performSegueWithIdentifier:kPhoneNumSegue sender:nil];
                }
                if ([weakSelf.registerViewModel.codeState isEqualToString:@"2"]) {//用户已存在直接调用登陆接口
                    [YDUserInfo sharedYDUserInfo].login = NO;
                    [YDUserInfo sharedYDUserInfo].userWxOpenID = @"fd56fd126d7eae0e41f74c895394155e";
                    
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
                            [self.view showWarning:@"登陆失败"];
                        }
                    }];
                    
                    
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
