//
//  BusinessViewController.m
//  YDElectricity
//
//  Created by 元典 on 2019/1/14.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import "BusinessViewController.h"
#import "ShareOrderViewController.h"
#import "InviteViewController.h"
#import "TeamMemberViewController.h"
#import "UserMoneyViewModel.h"
#import "LoginViewController.h"
#import "CashRecordViewController.h"
#import "MyIdentifyViewController.h"
#import "TaskCenterController.h"
#import "CashDetailViewController.h"
#import "GetCashViewController.h"

#define kShareOrderViewController @"ShareOrderViewController"
#define kInviteViewController @"InviteViewController"
#define kTeamMemberViewController @"TeamMemberViewController"
#define kCashRecordViewController @"CashRecordViewController"
#define kMyIdentifyViewController @"MyIdentifyViewController"
#define kTaskCenterController @"TaskCenterController"
#define kCashDetailViewController @"CashDetailViewController"
#define kGetCashViewController @"GetCashViewController"


@interface BusinessViewController ()
@property (weak, nonatomic) IBOutlet UILabel *userBalanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *userFreezeFundsLabel;
@property (weak, nonatomic) IBOutlet UILabel *userGrandTotalIncomeLabel;
@property (weak, nonatomic) IBOutlet UILabel *userWaitSettleLabel;


@property (weak, nonatomic) IBOutlet UIView *headerTopView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerTopViewHeightC;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *businessViewHeightC;

@property (nonatomic,strong)UserMoneyViewModel *moneyVM;

@end

@implementation BusinessViewController

#pragma mark -- 懒加载

-(UserMoneyViewModel *)moneyVM{
    
    if (!_moneyVM) {
        _moneyVM = [UserMoneyViewModel new];
    }
    return _moneyVM;
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];

  
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kViewBGColor;
    if (iPhoneX) {
//        self.businessViewHeightC.constant += STATUS_BAR_HEIGHT;//20
        self.headerTopViewHeightC.constant = 20;
        self.headerTopView.backgroundColor = kFONTSlectRGB;
        
    }else{
       self.headerTopViewHeightC.constant = 0;
    }
    //请求数据
    [self requestData];
}


//查看明细
- (IBAction)showMoneyDetail:(id)sender {
    if (![YDUserInfo sharedYDUserInfo].login) {
        [Factory noneLoginTipConfrimBolck:^{
            [self userNoneLoginTip];
        } CancelBlock:^{

        }];
        return;
    }
//    [Factory showWaittingForOpened];
 
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kYDBusiness bundle:nil];
    CashDetailViewController *cashVC = [storyboard instantiateViewControllerWithIdentifier:kCashDetailViewController];
    [self.navigationController pushViewController:cashVC animated:YES];
}

//提现
- (IBAction)checkOutMoney:(id)sender {
    if (![YDUserInfo sharedYDUserInfo].login) {
        [Factory noneLoginTipConfrimBolck:^{
            [self userNoneLoginTip];
        } CancelBlock:^{

        }];
        return;
    }
//    [Factory showWaittingForOpened];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kYDBusiness bundle:nil];
    GetCashViewController *getCashVC = [storyboard instantiateViewControllerWithIdentifier:kGetCashViewController];
    [self.navigationController pushViewController:getCashVC animated:YES];
}


//待结算资金
- (IBAction)waittingCheckClearMoney:(id)sender {
    if (![YDUserInfo sharedYDUserInfo].login) {
        [Factory noneLoginTipConfrimBolck:^{
            [self userNoneLoginTip];
        } CancelBlock:^{
            
        }];
        return;
    }
//    [Factory showWaittingForOpened];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kYDBusiness bundle:nil];
    ShareOrderViewController *shareVC = [storyboard instantiateViewControllerWithIdentifier:kShareOrderViewController];
    [self.navigationController pushViewController:shareVC animated:YES];
}



//我的身份
- (IBAction)myIdentityBtnClick:(id)sender {
    
    if (![YDUserInfo sharedYDUserInfo].login) {
        [Factory noneLoginTipConfrimBolck:^{
            [self userNoneLoginTip];
        } CancelBlock:^{
            
        }];
        return;
    }
    
//    [Factory showWaittingForOpened];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kYDBusiness bundle:nil];
    MyIdentifyViewController *iVC = [storyboard instantiateViewControllerWithIdentifier:kMyIdentifyViewController];
    [self.navigationController pushViewController:iVC animated:YES];
    
}

//团队成员
- (IBAction)teamMemberBtnClick:(id)sender {
    if (![YDUserInfo sharedYDUserInfo].login) {
        [Factory noneLoginTipConfrimBolck:^{
            [self userNoneLoginTip];
        } CancelBlock:^{
            
        }];
        return;
    }
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kYDBusiness bundle:nil];
    TeamMemberViewController *teamVC = [storyboard instantiateViewControllerWithIdentifier:kTeamMemberViewController];
    [self.navigationController pushViewController:teamVC animated:YES];
}

//分享订单
- (IBAction)shareOrderBtnClick:(id)sender {
    if (![YDUserInfo sharedYDUserInfo].login) {
        [Factory noneLoginTipConfrimBolck:^{
            [self userNoneLoginTip];
        } CancelBlock:^{
            
        }];
        return;
    }
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kYDBusiness bundle:nil];
    ShareOrderViewController *shareVC = [storyboard instantiateViewControllerWithIdentifier:kShareOrderViewController];
    [self.navigationController pushViewController:shareVC animated:YES];
    
    
}

//推荐邀请
- (IBAction)inviteBtnClick:(id)sender {
    if (![YDUserInfo sharedYDUserInfo].login) {
        [Factory noneLoginTipConfrimBolck:^{
            [self userNoneLoginTip];
        } CancelBlock:^{
            
        }];
        return;
    }
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kYDBusiness bundle:nil];
    InviteViewController *inviteVC = [storyboard instantiateViewControllerWithIdentifier:kInviteViewController];
    [self.navigationController pushViewController:inviteVC animated:YES];
}

//任务中心
- (IBAction)taskCenterBtnClick:(id)sender {
    if (![YDUserInfo sharedYDUserInfo].login) {
        [Factory noneLoginTipConfrimBolck:^{
            [self userNoneLoginTip];
        } CancelBlock:^{
            
        }];
        return;
    }
//    [Factory showWaittingForOpened];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kYDBusiness bundle:nil];
    TaskCenterController *taskVC = [storyboard instantiateViewControllerWithIdentifier:kTaskCenterController];
    [self.navigationController pushViewController:taskVC animated:YES];
    
}

//创业排名
- (IBAction)businessRankBtnClick:(id)sender {
    if (![YDUserInfo sharedYDUserInfo].login) {
        [Factory noneLoginTipConfrimBolck:^{
            [self userNoneLoginTip];
        } CancelBlock:^{
            
        }];
        return;
    }
    [Factory showWaittingForOpened];
}


-(void)requestData{
     WK(weakSelf)
    if (![YDUserInfo sharedYDUserInfo].login) {
        return;
    }
    
    [self.view showBusyHUD];

    [self.moneyVM getUserMoneyInfoCompletionHandler:^(NSError * _Nonnull error) {
        if (!error) {
            [weakSelf setUpChild];
            [weakSelf.view hideBusyHUD];
        }else{
            YDAlertView *alert = [[YDAlertView alloc] initWithFrame:kAlertRect withTitle:@"用户资金提示" alertMessage:@"资金数据有有误" confrimBolck:^{
                
            } cancelBlock:^{
                
            }];
            [alert show];
        }
    }];
}


-(void)setUpChild{
    self.userBalanceLabel.text = [self.moneyVM userBalance];
    self.userFreezeFundsLabel.text = [self.moneyVM userFreezeFunds];
    self.userGrandTotalIncomeLabel.text = [self.moneyVM userGrandTotalIncome];
    self.userWaitSettleLabel.text = [self.moneyVM userWaitSettle];
}

-(void)userNoneLoginTip{
    [Factory noneLoginTipConfrimBolck:^{
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kLogin bundle:nil];
        LoginViewController *loginVC = [storyboard instantiateViewControllerWithIdentifier:kLogin];
        [[[UIApplication sharedApplication] delegate] window].rootViewController = loginVC;
    } CancelBlock:^{
        
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
