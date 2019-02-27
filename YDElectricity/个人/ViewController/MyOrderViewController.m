//
//  MyOrderViewController.m
//  YDElectricity
//
//  Created by 元典 on 2019/1/10.
//  Copyright © 2019 yuandian. All rights reserved.
//

/*
 //1、声明一个局部变量来存储底部横线
 UIImageView *navBarHairlineImageView;
 
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
 //3、在viewWillAppear，viewWillDisappear中处理，找到那条横线在页面显示时隐藏，消失时出现
 - (void)viewWillAppear:(BOOL)animated {
 [super viewWillAppear:animated];
 navBarHairlineImageView.hidden = YES;
 }
 
 - (void)viewWillDisappear:(BOOL)animated {
 [super viewWillDisappear:animated];
 navBarHairlineImageView.hidden = NO;
 
 }
 
 
 */

#import "MyOrderViewController.h"
#import "MJCSegmentInterface.h"
#import "MyOrderChildViewController.h"


@interface MyOrderViewController ()<MJCSegmentDelegate>
@property(nonatomic,strong)UIImageView *navBarHairlineImageView;
@property(nonatomic,strong)NSMutableArray *timesArr;

@end

@implementation MyOrderViewController

#pragma mark -- 生命周期
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navBarHairlineImageView = [Factory findHairlineImageViewUnder:self.navigationController.navigationBar];
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
    NSMutableArray *vcsArr = [NSMutableArray new];
    NSArray *titleArr = @[@"全部",@"已付款",@"已结算",@"已失效"];
    
    for (int i = 0; i < titleArr.count; ++i) {
        MyOrderChildViewController *childVC = [MyOrderChildViewController new];
        childVC.userPid = self.userPid;
        if (i == 0) {
            childVC.orderMode = OrderTypeALL;
        }
        else if (i == 1){
            childVC.orderMode = OrderTypeBUYED;
        }
        else if (i == 2){
            childVC.orderMode = OrderTypeCLOSE;
        }
        else if (i == 3){
            childVC.orderMode = OrderTypeDISABLE;
        }
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
    
    MJCSegmentInterface *interFace = [MJCSegmentInterface jc_initWithFrame:CGRectMake(0, 16, self.view.jc_width, self.view.jc_height-16) interFaceStyleToolsBlock:^(MJCSegmentStylesTools *jc_tools) {
        jc_tools.
        jc_titleBarStyles(MJCTitlesClassicStyle).
        jc_childScollEnabled(YES).
        jc_titlesViewBackColor([UIColor whiteColor]).
        jc_itemTextNormalColor(kRGBA(115, 115, 115, 1)).
        jc_itemTextSelectedColor(kFONTSlectRGB).
        //        jc_itemSelectedSegmentIndex(3).
        jc_defaultItemShowCount(6).
        jc_itemTextFontSize(14 * kWidthScall).
        jc_indicatorStyles(MJCIndicatorEqualItemEffect).
        jc_indicatorsAnimalsEnabled(YES).
        jc_indicatorColorEqualTextColorEnabled(YES).
        jc_indicatorStyles(MJCIndicatorEqualItemEffect).
        jc_titlesViewFrame(CGRectMake(0, 0, self.view.jc_width, 50 * kWidthScall));
        
    }];
    interFace.delegate = self;
    [interFace intoTitlesArray:titlesArr intoChildControllerArray:vcArr hostController:self];
    [self.view addSubview:interFace];
    
    
    //    MJCSegmentStylesTools *tools = [MJCSegmentStylesTools jc_initWithSegmentStylestoolsBlock:^(MJCSegmentStylesTools *jc_tools) {
    //        jc_tools.
    //        jc_titleBarStyles(MJCTitlesClassicStyle).
    //        jc_titlesViewBackColor([UIColor whiteColor]).
    //        jc_itemTextNormalColor([UIColor redColor]).
    //        jc_itemTextSelectedColor([UIColor purpleColor]).
    //        jc_itemSelectedSegmentIndex(3).
    //        jc_defaultItemShowCount(6).
    //        jc_itemTextFontSize(11).
    //        jc_indicatorStyles(MJCIndicatorEqualTextEffect).
    //        jc_indicatorsAnimalsEnabled(YES).
    //        jc_titlesViewFrame(CGRectMake(0, 0, self.view.jc_width, 50));
    //    }];
    //
    //    MJCSegmentInterface *interFace =  [[MJCSegmentInterface alloc]init];
    //    interFace.frame = CGRectMake(0,64,self.view.jc_width, self.view.jc_height-64);
    //    interFace.jc_stylesTools = tools;
    //    [interFace intoTitlesArray:titlesArr intoChildControllerArray:vcArr hostController:self];
    //    [self.view addSubview:interFace];
    
}

-(void)dealloc
{
    NSLog(@"%@销毁了",self);
}

/** 选中点击item会调用的代理方法 */
- (void)mjc_ClickEventWithItem:(UIButton *)tabItem childsController:(UIViewController *)childsController segmentInterface:(MJCSegmentInterface *)segmentInterface{
    NSLog(@"dkfjdkjfdk==");
    MyOrderChildViewController *childVC = (MyOrderChildViewController *)childsController;
    [childVC request];
    
}
/** 取消选中点击item状态会调用的代理方法 */
- (void)mjc_cancelClickEventWithItem:(UIButton *)tabItem childsController:(UIViewController *)childsController segmentInterface:(MJCSegmentInterface *)segmentInterface{
    
}
/** 手拽滑动结束之后调用的代理方法 */
- (void)mjc_scrollDidEndDeceleratingWithItem:(UIButton *)tabItem childsController:(UIViewController *)childsController indexPage:(NSInteger)indexPage segmentInterface:(MJCSegmentInterface *)segmentInterface{
    NSLog(@"indepage:%ld",indexPage);
    MyOrderChildViewController *childVC = (MyOrderChildViewController *)childsController;
    [childVC request];
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
