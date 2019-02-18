//
//  ServerCenterViewController.m
//  YDElectricity
//
//  Created by 元典 on 2019/1/11.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import "ServerCenterViewController.h"

#import "FrequentlyQViewController.h"


#define kFreqentlyQViewController @"FrequentlyQViewController"

@interface ServerCenterViewController ()

@end

@implementation ServerCenterViewController

#pragma mark -- 生命周期
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

//QQ客服
- (IBAction)QQServerBtnClck:(id)sender {
    YDAlertView *alert = [[YDAlertView alloc] initWithFrame:kAlertRect withTitle:@"是否跳转到QQ?" alertMessage:@"384111389" confrimBolck:^{
        
    } cancelBlock:^{
        
    }];
    [alert show];
}

//客服热线
- (IBAction)serverHotLineBtnClick:(id)sender {
    YDAlertView *alert = [[YDAlertView alloc] initWithFrame:kAlertRect withTitle:@"是否拨打客服热线?" alertMessage:@"400-0399-386" confrimBolck:^{
        
    } cancelBlock:^{
        
    }];
    [alert show];
}

//常见问题
- (IBAction)frequentlyQBtnClick:(id)sender {
    UIStoryboard *board = [UIStoryboard storyboardWithName:kYDPersonal bundle:nil];
    FrequentlyQViewController *fvc = [board instantiateViewControllerWithIdentifier:kFreqentlyQViewController];
    [self.navigationController pushViewController:fvc animated:YES];
}


- (IBAction)serverCenterVCBackBtnClick:(id)sender {
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
