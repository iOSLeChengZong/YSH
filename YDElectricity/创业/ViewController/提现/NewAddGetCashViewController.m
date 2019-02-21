//
//  NewAddGetCashViewController.m
//  YDElectricity
//
//  Created by 元典 on 2019/2/21.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import "NewAddGetCashViewController.h"
#import <BRPickerView.h>

@interface NewAddGetCashViewController ()<UITextFieldDelegate>

//账户类型Label
@property (weak, nonatomic) IBOutlet UILabel *accountTypeLabel;

//账号texfield
@property (weak, nonatomic) IBOutlet UITextField *textField0;

//姓名texfield
@property (weak, nonatomic) IBOutlet UITextField *textField1;
//身份证号码textfield
@property (weak, nonatomic) IBOutlet UITextField *textField2;
//验证码textfild
@property (weak, nonatomic) IBOutlet UITextField *textField3;



@end

@implementation NewAddGetCashViewController

#pragma mark -- 生命周期
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

//账户类型按钮点击
- (IBAction)accountTypeBtnClick:(id)sender {
    WK(weakSelf)
    [BRStringPickerView showStringPickerWithTitle:@"账户" dataSource:@[@"支付宝", @"微信", @"中国很行",@"招商很行"] defaultSelValue:@"" isAutoSelect:NO themeColor:kFONTSlectRGB resultBlock:^(id selectValue) {
        weakSelf.accountTypeLabel.text = selectValue;
    }];
}


#pragma mark - UITextFieldDelegate 返回键
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [textField addTarget:self action:@selector(handlerTextFieldEndEdit:) forControlEvents:UIControlEventEditingDidEnd];
    return YES;
}

//#pragma mark - 处理编辑事件
- (void)handlerTextFieldEndEdit:(UITextField *)textField {
    NSLog(@"结束编辑:%ld", textField.tag);
    switch (textField.tag) {
        case 0:
        {
            [textField setTextColor:kFONTSlectRGB];
        }
            break;
        case 1:
        {
            [textField setTextColor:kFONTSlectRGB];
        }
            break;

        case 2:
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


- (IBAction)bindingBtnClick:(id)sender {
    //验证数据合法性 有一个为空,则数据不合法
    BOOL b0 = self.textField0.text.length == 0;
    BOOL b1 = self.textField1.text.length == 0;
    BOOL b2 = self.textField2.text.length == 0;
    BOOL b3 = self.textField3.text.length == 0;
    if (b0 || b1 || b2 || b3) {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"请检查数据正确性" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alertC addAction:alertAction];
        [self presentViewController:alertC animated:YES completion:nil];
        return;
    }
    //将服务器提交账号,待成功返回
    
    
    
    [self.view showWarning:@"绑定成功!"];
    
}

- (IBAction)newAddGetCashVCBackBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
