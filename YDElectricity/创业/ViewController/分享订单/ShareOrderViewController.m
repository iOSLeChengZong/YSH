//
//  ShareOrderViewController.m
//  YDElectricity
//
//  Created by 元典 on 2019/1/14.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import "ShareOrderViewController.h"
#import "MJCSegmentInterface.h"
#import "ShareOrderChildViewController.h"

static CGFloat const titleViewsH = 50;
static CGFloat const titieViewEdige = 9;

@interface ShareOrderViewController ()<MJCSegmentDelegate>
@property(nonatomic,strong)UIImageView *navBarHairlineImageView;
@property(nonatomic,strong)UIView *menuView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerTop;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIView *menuBgView;


@end

@implementation ShareOrderViewController

#pragma mark -- 生命周期
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navBarHairlineImageView.hidden = YES;
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.navBarHairlineImageView.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kViewBGColor;
    
    
    self.navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    
    NSMutableArray *vcsArr = [NSMutableArray new];
    NSArray *titleArr = @[@"全部(253)",@"成交订单(250)",@"退款订单(3)"];
    
    for (int i = 0; i < titleArr.count; ++i) {
        ShareOrderChildViewController *childVC = [ShareOrderChildViewController new];
        childVC.collectionViewY = NAVIGATION_BAR_HEIGHT + self.headerTop.constant + self.headerView.bounds.size.height + 10.0 + titleViewsH;
        [vcsArr addObject:childVC];
    }
    
    //    for (int i = 0 ; i < vcArr.count; i++) {//赋值标题
    //        UIViewController *vc = vcArr[i];
    //        vc.title = titleArr[i];
    //    }
    
    [self setupInterfaceWithTitlesArr:titleArr vcArr:vcsArr];
    
    
    
}


-(void)setupInterfaceWithTitlesArr:(NSArray*)titlesArr vcArr:(NSArray*)vcArr
{
    
    MJCSegmentInterface *interFace = [MJCSegmentInterface jc_initWithFrame:CGRectMake(0,self.headerTop.constant + self.headerView.bounds.size.height + 10, self.view.jc_width, self.view.jc_height - (self.headerTop.constant + self.headerView.bounds.size.height + 10)) interFaceStyleToolsBlock:^(MJCSegmentStylesTools *jc_tools) {
        jc_tools.
        jc_titleBarStyles(MJCTitlesClassicStyle).
        jc_childScollEnabled(YES).
        jc_childScollAnimalEnabled(YES).
        jc_loadAllChildViewEnabled(YES).
        jc_titlesViewBackColor([UIColor whiteColor]).
        jc_itemTextNormalColor(kRGBA(115, 115, 115, 1)).
        jc_itemTextSelectedColor(kFONTSlectRGB).
        //        jc_itemSelectedSegmentIndex(3).
        jc_defaultItemShowCount(6).
        jc_itemTextFontSize(12*kWidthScall).
        jc_indicatorStyles(MJCIndicatorEqualItemEffect).
        jc_indicatorsAnimalsEnabled(YES).
        jc_indicatorFollowEnabled(YES).
        jc_indicatorColorEqualTextColorEnabled(YES).
        jc_titlesViewFrame(CGRectMake(titieViewEdige, 0, self.view.jc_width - 2 * titieViewEdige, titleViewsH * kWidthScall));
        
    }];
    interFace.delegate = self;
    [interFace intoTitlesArray:titlesArr intoChildControllerArray:vcArr hostController:self];
    [self.view addSubview:interFace];
    
    
}

-(void)dealloc
{
    NSLog(@"%@销毁了",self);
}

/** 选中点击item会调用的代理方法 */
- (void)mjc_ClickEventWithItem:(UIButton *)tabItem childsController:(UIViewController *)childsController segmentInterface:(MJCSegmentInterface *)segmentInterface{
    NSLog(@"dkfjdkjfdk==");
    ShareOrderChildViewController *childVC = (ShareOrderChildViewController *)childsController;
    [childVC requestStr:@""];
    
}
/** 取消选中点击item状态会调用的代理方法 */
- (void)mjc_cancelClickEventWithItem:(UIButton *)tabItem childsController:(UIViewController *)childsController segmentInterface:(MJCSegmentInterface *)segmentInterface{
    
}
/** 手拽滑动结束之后调用的代理方法 */
- (void)mjc_scrollDidEndDeceleratingWithItem:(UIButton *)tabItem childsController:(UIViewController *)childsController indexPage:(NSInteger)indexPage segmentInterface:(MJCSegmentInterface *)segmentInterface{
    NSLog(@"indepage:%ld",indexPage);
    ShareOrderChildViewController *childVC = (ShareOrderChildViewController *)childsController;
    [childVC requestStr:@""];
}
/** 获取到所有item的代理方法(可在item上面添加新的控件) */
- (void)mjc_tabitemDataWithTabitemArray:(NSArray<UIButton*>*)tabItemArray childsVCAarray:(NSArray<UIViewController*>*)childsVCAarray segmentInterface:(MJCSegmentInterface *)segmentInterface{
    for (int i = 0; i < tabItemArray.count; ++i) {
        UIView *view = [[UIView alloc] init];
        if (i == 0) {
           view.frame = CGRectMake(10, tabItemArray[i].frame.size.height -1, tabItemArray[i].frame.size.width -10, 1);
        }
        else if (i == tabItemArray.count -1)
        {
            view.frame = CGRectMake(0, tabItemArray[i].frame.size.height -1, tabItemArray[i].frame.size.width -10, 1);
        }else{
            view.frame = CGRectMake(0, tabItemArray[i].frame.size.height -1, tabItemArray[i].frame.size.width, 1);
        }
        
        view.backgroundColor = [UIColor darkGrayColor];
        [tabItemArray[i] addSubview:view];
    }
}

- (IBAction)myOrderBackBtnClick:(id)sender {
    NSLog(@"======");
    [self.navigationController popViewControllerAnimated:YES];
}

//分享说明
- (IBAction)shareDeclare:(id)sender {
    NSString *str = @"1.待结算资金,指分享商品已完成交易订单(累计7天) 所产生的佣金;2.每个月的1号系统自动结算资金,结算后的资金将划入到可用余额内";
    YDAlertView *alertView = [[YDAlertView alloc] initWithFrame:kAlertRect withTitle:@"说明" alertMessage:str confrimBolck:^{
        
    } cancelBlock:^{
        
    }];
    [alertView show];
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

-(UIView *)addMenu{
    
    _menuView = [[UIView alloc] init];
    _menuView.frame = CGRectMake(titieViewEdige, self.headerTop.constant + self.headerView.bounds.size.height + 10 + titleViewsH, kScreenW - 2 * titieViewEdige, 30);
    //订单日期
    UILabel *label0 = [[UILabel alloc] init];
    
    [_menuView addSubview:label0];
    //订单号
    UILabel *label1 = [[UILabel alloc] init];
    [_menuView addSubview:label1];
    //奖金
    UILabel *label2 = [[UILabel alloc] init];
    [_menuView addSubview:label2];
    //状态
    UILabel *label3 = [[UILabel alloc] init];
    [_menuView addSubview:label3];
    return _menuView;
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
