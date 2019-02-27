//
//  DiscountCouponViewController.m
//  YDElectricity
//
//  Created by 元典 on 2019/2/19.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import "DiscountCouponViewController.h"
#import "MJCSegmentInterface.h"
#import "DiscountCouponChildViewController.h"

@interface DiscountCouponViewController ()<MJCSegmentDelegate>

@end

@implementation DiscountCouponViewController

#pragma mark -- 生命周期
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [Factory findHairlineImageViewUnder:self.navigationController.navigationBar].hidden = YES;
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [Factory findHairlineImageViewUnder:self.navigationController.navigationBar].hidden = NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kViewBGColor;
    NSMutableArray *vcsArr = [NSMutableArray new];
    NSArray *titleArr = @[@"可用优惠券",@"不可用优惠券"];
    
    for (int i = 0; i < titleArr.count; ++i) {
        DiscountCouponChildViewController *childVC = [DiscountCouponChildViewController new];
        
//        if (i == 0) {
//            childVC.orderMode = OrderTypeALL;
//        }
//        else if (i == 1){
//            childVC.orderMode = OrderTypeBUYED;
//        }
//        else if (i == 2){
//            childVC.orderMode = OrderTypeCLOSE;
//        }
//        else if (i == 3){
//            childVC.orderMode = OrderTypeDISABLE;
//        }
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
    
    MJCSegmentInterface *interFace = [MJCSegmentInterface jc_initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, self.view.jc_width, self.view.jc_height-16) interFaceStyleToolsBlock:^(MJCSegmentStylesTools *jc_tools) {
        jc_tools.
        jc_titleBarStyles(MJCTitlesClassicStyle).
        jc_childScollEnabled(YES).
        jc_titlesViewBackColor([UIColor whiteColor]).
        jc_itemTextNormalColor(KFontDefaultRGB).
        jc_itemTextSelectedColor(kFONTSlectRGB).
        //        jc_itemSelectedSegmentIndex(3).
        jc_defaultItemShowCount(6).
        jc_itemTextFontSize(14 * kWidthScall).
        jc_indicatorStyles(MJCIndicatorEqualTextEffect).
        jc_indicatorsAnimalsEnabled(YES).
        jc_indicatorColorEqualTextColorEnabled(YES).
        jc_indicatorStyles(MJCIndicatorEqualItemEffect).
        jc_titlesViewFrame(CGRectMake(0, 0, self.view.jc_width, 50));
        
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
    DiscountCouponChildViewController *childVC = (DiscountCouponChildViewController *)childsController;
    [childVC request];
    
}
/** 取消选中点击item状态会调用的代理方法 */
- (void)mjc_cancelClickEventWithItem:(UIButton *)tabItem childsController:(UIViewController *)childsController segmentInterface:(MJCSegmentInterface *)segmentInterface{
    
}
/** 手拽滑动结束之后调用的代理方法 */
- (void)mjc_scrollDidEndDeceleratingWithItem:(UIButton *)tabItem childsController:(UIViewController *)childsController indexPage:(NSInteger)indexPage segmentInterface:(MJCSegmentInterface *)segmentInterface{
    DiscountCouponChildViewController *childVC = (DiscountCouponChildViewController *)childsController;
    [childVC request];
}
/** 获取到所有item的代理方法(可在item上面添加新的控件) */
- (void)mjc_tabitemDataWithTabitemArray:(NSArray<UIButton*>*)tabItemArray childsVCAarray:(NSArray<UIViewController*>*)childsVCAarray segmentInterface:(MJCSegmentInterface *)segmentInterface{
    
}

- (IBAction)discountCouponVCBackBtnClick:(id)sender {
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
