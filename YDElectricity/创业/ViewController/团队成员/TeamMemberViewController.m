//
//  TeamMemberViewController.m
//  YDElectricity
//
//  Created by 元典 on 2019/1/14.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import "TeamMemberViewController.h"
#import "InviteDetailViewController.h"
#import "UserTeamMemberViewModel.h"

#define kInviteDetailViewController @"InviteDetailViewController"

@interface TeamMemberViewController ()
@property(nonatomic,strong)UIImageView *navBarHairlineImageView;
//累计团队贡献额
@property (weak, nonatomic) IBOutlet UILabel *totalContribute;

//累计奖金
@property (weak, nonatomic) IBOutlet UILabel *totalBonus;

//累计培训津贴
@property (weak, nonatomic) IBOutlet UILabel *totalTrain;

//消费者低级
@property (weak, nonatomic) IBOutlet UIView *customerParentV;

//消费者
@property (weak, nonatomic) IBOutlet UILabel *customerNum;

//创业者父级
@property (weak, nonatomic) IBOutlet UIView *businessParentV;

//创业者
@property (weak, nonatomic) IBOutlet UILabel *businessNum;

//总经理父级
@property (weak, nonatomic) IBOutlet UIView *managerParent;

//总经理
@property (weak, nonatomic) IBOutlet UILabel *managerNum;

@property (weak, nonatomic) IBOutlet UIView *shipParent;

//合伙人
@property (weak, nonatomic) IBOutlet UILabel *shipNum;

//我的团队父级
@property (weak, nonatomic) IBOutlet UIView *myTeamParent;

//我的团队
@property (weak, nonatomic) IBOutlet UILabel *myTeamNum;


@property(nonatomic,strong)UserTeamMemberViewModel *teamVM;


@end

@implementation TeamMemberViewController

#pragma mark -- 懒加载
-(UserTeamMemberViewModel *)teamVM{
    if (!_teamVM) {
        _teamVM = [UserTeamMemberViewModel new];
    }
    return _teamVM;
}

#pragma mark -- 生命周期
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navBarHairlineImageView.hidden = YES;
    [self setUpChild];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.navBarHairlineImageView.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    
    [self.view showBusyHUD];
    [self.teamVM getTeamMemberCompletionHandler:^(NSError * _Nonnull error) {
        if (!error) {
         
            [self setUpChild1];
            [self.view hideBusyHUD];
        }
    }];
}



//2、找出底部横线的函数
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}


- (IBAction)showInviteRecordBtnClick:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kYDBusiness bundle:nil];
    InviteDetailViewController *inviteDetailVC = [storyboard instantiateViewControllerWithIdentifier:kInviteDetailViewController];
    [self.navigationController pushViewController:inviteDetailVC animated:YES];
}


- (IBAction)teamMemberBackBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)setUpChild{
    [self.customerParentV viewcornerRadius:5 borderWith:0.02 clearColor:NO];
    [self.businessParentV viewcornerRadius:5 borderWith:0.02 clearColor:NO];
    [self.managerParent viewcornerRadius:5 borderWith:0.02 clearColor:NO];
    [self.shipParent viewcornerRadius:5 borderWith:0.02 clearColor:NO];
    [self.myTeamParent viewcornerRadius:self.myTeamParent.bounds.size.height * 0.5 borderWith:0/02 clearColor:NO];
    
}

-(void)setUpChild1{
   
    self.totalContribute.text = [self.teamVM totalContribute];
    self.totalBonus.text = [self.teamVM totalBonus];
    self.totalTrain.text = [self.teamVM totalTrain];
    self.customerNum.text = [self.teamVM totalCustomerNum];
    self.businessNum.text = [self.teamVM businessNum];
    self.managerNum.text = [self.teamVM managerNum];
    self.shipNum.text = [self.teamVM shipNum];
    self.myTeamNum.text = [self.teamVM myTeamNum];
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
