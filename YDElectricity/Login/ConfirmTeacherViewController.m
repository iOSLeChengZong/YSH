//
//  ConfirmTeacherViewController.m
//  YDElectricity
//
//  Created by 元典 on 2018/12/18.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import "ConfirmTeacherViewController.h"
#import "YDUserInfo.h"
//#import "VefifyRegisterViewModel.h"


@interface ConfirmTeacherViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *OwnSelectTeacherTextField;
@property (nonatomic,strong) VefifyRegisterViewModel *registerVM;

@end

@implementation ConfirmTeacherViewController

-(VefifyRegisterViewModel *)registerVM{
    if (!_registerVM) {
        _registerVM = [VefifyRegisterViewModel sharedVefifyRegisterViewModel];
    }
    return _registerVM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSLog(@"%@:phoneNumber:%@",[self class],[YDUserInfo sharedYDUserInfo].phoneNumber);
    NSLog(@"%@:wxid:%@",[self class],[YDUserInfo sharedYDUserInfo].userWxOpenID);
}
- (IBAction)OnOwnTeacherBtnClick:(id)sender {
    WK(weakSelf)
    if (self.OwnSelectTeacherTextField.text.length < 1 || [self.OwnSelectTeacherTextField.text isEqualToString:@" "]) {
        [self.view showWarning:@"请填写导师邀请码"];
        
    }else{
        //请求注册
        [weakSelf.registerVM requestRegisterWithInviteCode:self.OwnSelectTeacherTextField.text CompletionHandler:^(NSError * _Nonnull error) {
            if (!error) {
//                [weakSelf saveNSUserDefaults];
                [weakSelf.view endEditing:YES];//强行关闭键盘
                [weakSelf.view showWarning:@"注册成功"];
                NSString *wxOpenID = [[NSUserDefaults standardUserDefaults] stringForKey:kUserWxOpenID];
                NSString *phoneNum = [[NSUserDefaults standardUserDefaults] stringForKey:kUserPhoneNum];
                [weakSelf.registerVM requestLoginWithParameter:wxOpenID phoneNum:phoneNum completionHandler:^(NSError * _Nonnull error) {
                    //请求登陆
                    if (!error && [[weakSelf.registerVM codeState] isEqualToString:@"1"]) {
                        [weakSelf.view showWarning:@"登陆成功"];
                        [YDUserInfo sharedYDUserInfo].login = YES;
                        [YDUserInfo sharedYDUserInfo].userToken = [self.registerVM tokenID];
                        [YDUserInfo sharedYDUserInfo].userID = [self.registerVM userID];
                        [weakSelf saveNSUserDefaults];
                       // 跳转界面;
                        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                        UITabBarController *tabVC = [storyboard instantiateViewControllerWithIdentifier:kMain];
                        [[[UIApplication sharedApplication] delegate] window].rootViewController = tabVC;
                    }else{
                       [weakSelf.view showWarning:@"登陆失败"];
                    }
                }];
            }else{
             [self.view showWarning:@"注册失败"];
            }
        }];
        
        
        
        
        
        
//
//        [YDUserInfo sharedYDUserInfo].tutorInviteCode = self.OwnSelectTeacherTextField.text;
//        WK(weakSelf)

//        请求注册
//        [[YDUserInfo sharedYDUserInfo] requestRegisterCompletionHandler:^(VerifyRegisterModel * _Nonnull model, NSError * _Nonnull error) {
//            if (!error && [model.code isEqualToString:@"1"]) {
//                //将用户信息保存
//                [weakSelf saveNSUserDefaults];
//                [self.view endEditing:YES];//强行关闭键盘
//                [self.view showWarning:@"注册成功"];
//                //注册成功调用登陆接口
//                [[YDUserInfo sharedYDUserInfo] requestLoginCompletionHandler:^(VerifyRegisterModel * _Nonnull model, NSError * _Nonnull error) {
//                    if (!error && [model.code isEqualToString:@"1"]){
//                        //保存token 保存 id
//                        [YDUserInfo sharedYDUserInfo].userToken = model.rows1.token;
//                        [YDUserInfo sharedYDUserInfo].userID = model.rows1.userInfo.ID;
//                        [self saveNSUserDefaults];
//                        [self.view showWarning:@"登陆成功"];
//                        [YDUserInfo sharedYDUserInfo].login = YES;
//                        //跳转界面;
//                        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//                        UITabBarController *tabVC = [storyboard instantiateViewControllerWithIdentifier:kMain];
//                        [[[UIApplication sharedApplication] delegate] window].rootViewController = tabVC;
//                    }else{
//                        [self.view showWarning:@"登陆失败"];
//                    }
//                }];
//
//
//            }
//            else{
//                [self.view showWarning:@"注册失败"];
//            }
//
//        }];
    }
    
}


- (IBAction)OnRecommendBtnClick:(id)sender {
    //即将开放
    [Factory showWaittingForOpened];
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


//保存数据到NSUserDefaults
-(void)saveNSUserDefaults
{
   
    //将上述数据全部存储到NSUserDefaults中
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    [userDefaults setObject:/*[self.registerVM wxOpenID]*/[YDUserInfo sharedYDUserInfo].userWxOpenID forKey:kUserWxOpenID];
//    [userDefaults setObject:/*[self.registerVM phoneNum]*/[YDUserInfo sharedYDUserInfo].phoneNumber forKey:kUserPhoneNum];

    [userDefaults setObject:/*[self.registerVM tokenID]*/[YDUserInfo sharedYDUserInfo].userToken  forKey:kUserToken];
    [userDefaults setObject:/*[self.registerVM userID]*/[YDUserInfo sharedYDUserInfo].userID forKey:kUserID];
    //这里建议同步存储到磁盘中，但是不是必须的
    [userDefaults synchronize];
    
    
    
}



/*
//保存数据到NSUserDefaults
-(void)saveNSUserDefaults
{
    NSString *myString = @"enuola";
    int myInteger = 100;
    float myFloat = 50.0f;
    double myDouble = 20.0;
    NSDate *myDate = [NSDate date];
    NSArray *myArray = [NSArray arrayWithObjects:@"hello", @"world", nil];
    NSDictionary *myDictionary = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"enuo", @"20", nil] forKeys:[NSArray arrayWithObjects:@"name", @"age", nil]];
    
    //将上述数据全部存储到NSUserDefaults中
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //存储时，除NSNumber类型使用对应的类型意外，其他的都是使用setObject:forKey:
    [userDefaults setInteger:myInteger forKey:@"myInteger"];
    [userDefaults setFloat:myFloat forKey:@"myFloat"];
    [userDefaults setDouble:myDouble forKey:@"myDouble"];
    
    [userDefaults setObject:myString forKey:@"myString"];
    [userDefaults setObject:myDate forKey:@"myDate"];
    [userDefaults setObject:myArray forKey:@"myArray"];
    [userDefaults setObject:myDictionary forKey:@"myDictionary"];
    
    //这里建议同步存储到磁盘中，但是不是必须的
    [userDefaults synchronize];
    
}

//从NSUserDefaults中读取数据
-(void)readNSUserDefaults
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    
    //读取数据到各个label中
    //读取整型int类型的数据
    NSInteger myInteger = [userDefaultes integerForKey:@"myInteger"];
    txtInteger.text = [NSString stringWithFormat:@"%d",myInteger];
    
    //读取浮点型float类型的数据
    float myFloat = [userDefaultes floatForKey:@"myFloat"];
    txtFloat.text = [NSString stringWithFormat:@"%f",myFloat];
    
    //读取double类型的数据
    double myDouble = [userDefaultes doubleForKey:@"myDouble"];
    txtDouble.text = [NSString stringWithFormat:@"%f",myDouble];
    
    //读取NSString类型的数据
    NSString *myString = [userDefaultes stringForKey:@"myString"];
    txtNSString.text = myString;
    
    //读取NSDate日期类型的数据
    NSDate *myDate = [userDefaultes valueForKey:@"myDate"];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    txtNSDate.text = [NSString stringWithFormat:@"%@",[df stringFromDate:myDate]];
    
    //读取数组NSArray类型的数据
    NSArray *myArray = [userDefaultes arrayForKey:@"myArray"];
    NSString *myArrayString = [[NSString alloc] init];
    for(NSString *str in myArray)
    {
        NSLog(@"str= %@",str);
        myArrayString = [NSString stringWithFormat:@"%@  %@", myArrayString, str];
        [myArrayString stringByAppendingString:str];
        //        [myArrayString stringByAppendingFormat:@"%@",str];
        NSLog(@"myArrayString=%@",myArrayString);
    }
    txtNSArray.text = myArrayString;
    
    //读取字典类型NSDictionary类型的数据
    NSDictionary *myDictionary = [userDefaultes dictionaryForKey:@"myDictionary"];
    NSString *myDicString = [NSString stringWithFormat:@"name:%@, age:%d",[myDictionary valueForKey:@"name"], [[myDictionary valueForKey:@"age"] integerValue]];
    txtNSDictionary.text = myDicString;
}
*/
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
