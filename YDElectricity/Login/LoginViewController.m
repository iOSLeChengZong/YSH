//
//  LoginViewController.m
//  YDElectricity
//
//  Created by 元典 on 2018/12/18.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import "LoginViewController.h"
//#import "VefifyRegisterViewModel.h"
#import "YDUserInfo.h"
#import <ShareSDK/ShareSDK.h>


@interface LoginViewController ()
@property(nonatomic,strong)VefifyRegisterViewModel *registerViewModel;
@property(nonatomic,strong)NSString *userWxID;
@property(nonatomic,strong)NSString *userPhonNum;
@property(nonatomic,strong)NSString *userNickName;



@end

@implementation LoginViewController

#pragma mark -- 懒加载
-(VefifyRegisterViewModel *)registerViewModel{
    if (!_registerViewModel) {
        _registerViewModel = [VefifyRegisterViewModel sharedVefifyRegisterViewModel];
    }
    return _registerViewModel;
}


#pragma mark -- 生命周期
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];

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
//
    
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
    //    [self getWeChatUserInfo];
    //    return;
    
    /*
     微信正式接入后的流程
    //1.获取微信信息
    NSString *tempUserWXID = [self requestWX];
    //2.与本地信息对比
    if ([self.userWxID isEqualToString:tempUserWXID]) {
        //登陆
        [YDUserInfo sharedYDUserInfo].userWxOpenID = tempUserWXID;
        [self.registerViewModel requestLoginWithParameter:tempUserWXID phoneNum:weakSelf.userPhonNum completionHandler:^(NSError * _Nonnull error) {
            [weakSelf requestLogin1:error];
        }];
        
    }else{
        //验证些tempUserWXID是否注册
        [self.registerViewModel getUserRegisterStateWithParameter:tempUserWXID completionHandler:^(NSError * _Nonnull error) {
            //没有注册
            if (!error && [[weakSelf.registerViewModel codeState] isEqualToString:@"3"]) {
                [YDUserInfo sharedYDUserInfo].userWxOpenID = weakSelf.userWxID;
                [weakSelf performSegueWithIdentifier:kPhoneNumSegue sender:nil];
            }
            
            //已经注册
            else if ([[weakSelf.registerViewModel codeState] isEqualToString:@"2"]){
                [YDUserInfo sharedYDUserInfo].userWxOpenID = tempUserWXID;
                [weakSelf.registerViewModel requestLoginWithParameter:tempUserWXID phoneNum:weakSelf.userPhonNum completionHandler:^(NSError * _Nonnull error) {
                    [weakSelf requestLogin1:error];
                }];
            }
            
        }];
        
    }
    */
    
   
    //->本地有微信 - > 请求登陆
    if (self.userWxID.length > 0) {
        NSLog(@"WXID:%@",self.userWxID);
        //有微信号,请求登陆
        [self.registerViewModel requestLoginWithParameter:self.userWxID phoneNum:self.userPhonNum completionHandler:^(NSError * _Nonnull error) {
            
            [weakSelf requestLogin1:error];
        }];
        
       
    }
     //->本地没有微信
    else{
        //1.跳转微信获取微信息,并得到微信信息
        weakSelf.userWxID = [weakSelf requestWX];
        //2.用获取的微信信息验证用户是否存在
        [weakSelf.registerViewModel getUserRegisterStateWithParameter:weakSelf.userWxID completionHandler:^(NSError * _Nonnull error) {
            //用户不存在 进行注册  跳转填写手机号码界面
            if (!error && [[weakSelf.registerViewModel codeState] isEqualToString:@"3"]) {
                [YDUserInfo sharedYDUserInfo].userWxOpenID = weakSelf.userWxID;
                [weakSelf performSegueWithIdentifier:kPhoneNumSegue sender:nil];
            }
            
            //用户存在 请求登陆  用于更换手机
            else if ([[weakSelf.registerViewModel codeState] isEqualToString:@"2"]){
                [YDUserInfo sharedYDUserInfo].userWxOpenID = weakSelf.userWxID;
                [self.registerViewModel requestLoginWithParameter:weakSelf.userWxID phoneNum:weakSelf.userPhonNum completionHandler:^(NSError * _Nonnull error) {
                    [weakSelf requestLogin1:error];
                }];
            }
        }];
        
    }

}


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



-(NSString *)requestWX{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *str = [formatter stringFromDate: [NSDate date]];
    NSArray *arr = [str componentsSeparatedByString:@" "];
    
    [YDUserInfo sharedYDUserInfo].userName = [ @"元典" stringByAppendingString:arr[1]];
    
    return [formatter stringFromDate: [NSDate date]];
}



//请求登陆
-(void)requestLogin1:(NSError *) error{
    //登陆成功
    if (!error && [[self.registerViewModel codeState] isEqualToString:@"1"]) {
        [YDUserInfo sharedYDUserInfo].userWxOpenID = [self.registerViewModel wxOpenID];
        [YDUserInfo sharedYDUserInfo].phoneNumber = [self.registerViewModel phoneNum];
        [YDUserInfo sharedYDUserInfo].userToken = [self.registerViewModel tokenID];
        [YDUserInfo sharedYDUserInfo].userID = [self.registerViewModel userID];
        //保存用户WXOpenID到本地
        [self saveNSUserDefaults];
        //跳转界面
        [self.view showWarning:@"登陆成功"];
        [YDUserInfo sharedYDUserInfo].login = YES;
        [self jumpToMainStoryboard];
        
    }else{
        [self.view showWarning:@"请检查手机号码或微信号是否存在"];
    }
}


//-(NSString *)readUserWXOpenID{
//
//    return [[NSUserDefaults standardUserDefaults] stringForKey:kUserWxOpenID];
//}

-(void)jumpToMainStoryboard{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITabBarController *tabVC = [storyboard instantiateViewControllerWithIdentifier:kMain];
    [[[UIApplication sharedApplication] delegate] window].rootViewController = tabVC;
}



-(void)getWeChatUserInfo{
    [ShareSDK getUserInfo:SSDKPlatformTypeWechat onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
        if (state == SSDKResponseStateSuccess) {
            NSLog(@"uid=%@",user.uid);
            NSLog(@"%@",user.credential);
            NSLog(@"token=%@",user.credential.token);
            NSLog(@"nickName=%@",user.nickname);
            NSLog(@"icon=%@",user.icon);
            NSLog(@"gender=%ld",user.gender);
            NSLog(@"birthday=%@",user.birthday);
            
            
        }
    }];
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
