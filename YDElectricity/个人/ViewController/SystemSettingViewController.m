//
//  SystemSettingViewController.m
//  YDElectricity
//
//  Created by 元典 on 2019/1/12.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import "SystemSettingViewController.h"
#import "IdearResponseRoViewController.h"

#define kIdearResponseRoViewController @"IdearResponseRoViewController"

@interface SystemSettingViewController ()

@end

@implementation SystemSettingViewController


#pragma mark -- 生命周期
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];

}

//-(void)viewDidDisappear:(BOOL)animated{
//    [super viewDidDisappear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
//}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kViewBGColor;
    // Do any additional setup after loading the view.
}



//清除缓存
- (IBAction)clearCache:(id)sender {
    [Factory showWaittingForOpened];
    
}

//版本说明
- (IBAction)versionDetail:(id)sender {
    [Factory showWaittingForOpened];
}


//意见反馈
- (IBAction)IdearResponseBtcnClick:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kYDPersonal bundle:nil];
    IdearResponseRoViewController *ivc = [storyboard instantiateViewControllerWithIdentifier:kIdearResponseRoViewController];
    [self.navigationController pushViewController:ivc animated:YES];
}

//修改密码
- (IBAction)updateCode:(id)sender {
    [Factory showWaittingForOpened];
}

//关于我们
- (IBAction)aboutOur:(id)sender {
    [Factory showWaittingForOpened];
    
}



//返回
- (IBAction)systemSettingBackBtnClick:(id)sender {
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
