//
//  SecondSkillViewController.m
//  YDElectricity
//
//  Created by 元典 on 2019/1/11.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import "SecondSkillViewController.h"
#import "MJCSegmentInterface.h"
#import "SecondSkillChildViewController.h"



@interface SecondSkillViewController ()<MJCSegmentDelegate>
@property(nonatomic,assign)NSInteger hour;
@property(nonatomic,strong)NSMutableArray *timeAarr;

@end

@implementation SecondSkillViewController

#pragma mark -- 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
   
    NSArray *titleArr = [self getTitleArr];
    NSMutableArray *vcArr = [NSMutableArray new];
    for (int i = 0; i < titleArr.count; ++i) {
        SecondSkillChildViewController *childVC = [[SecondSkillChildViewController alloc] init];
        [vcArr addObject:childVC];
    }
    
    [self setupInterfaceWithTitlesArr:titleArr vcArr:vcArr];

    
}



/** 选中点击item会调用的代理方法 */
- (void)mjc_ClickEventWithItem:(UIButton *)tabItem childsController:(UIViewController *)childsController segmentInterface:(MJCSegmentInterface *)segmentInterface{
//    NSLog(@"ttttttaggg:%ld class:%f",childsController.view.tag,tabItem.frame.size.height);

    [tabItem viewcornerRadius:5 borderWith:0.02 clearColor:NO];
    [tabItem setBackgroundColor:kFONTSlectRGB];
    SecondSkillChildViewController *childVC = (SecondSkillChildViewController *)childsController;
    [childVC requestData:[tabItem.titleLabel.text componentsSeparatedByString:@":"][0]];
    
}
/** 取消选中点击item状态会调用的代理方法 */
- (void)mjc_cancelClickEventWithItem:(UIButton *)tabItem childsController:(UIViewController *)childsController segmentInterface:(MJCSegmentInterface *)segmentInterface{
    [tabItem setBackgroundColor:[UIColor blackColor]];
}
/** 手拽滑动结束之后调用的代理方法 */
- (void)mjc_scrollDidEndDeceleratingWithItem:(UIButton *)tabItem childsController:(UIViewController *)childsController indexPage:(NSInteger)indexPage segmentInterface:(MJCSegmentInterface *)segmentInterface{
    [tabItem viewcornerRadius:5 borderWith:0.02 clearColor:NO];
    [tabItem setBackgroundColor:kFONTSlectRGB];
    SecondSkillChildViewController *childVC = (SecondSkillChildViewController *)childsController;
    [childVC requestData:[tabItem.titleLabel.text componentsSeparatedByString:@":"][0]];
}

/** 获取到所有item的代理方法(可在item上面添加新的控件) */
- (void)mjc_tabitemDataWithTabitemArray:(NSArray<UIButton*>*)tabItemArray childsVCAarray:(NSArray<UIViewController*>*)childsVCAarray segmentInterface:(MJCSegmentInterface *)segmentInterface{
    NSInteger i = 0;
    for (UIButton *tabBtn in tabItemArray) {
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, tabBtn.frame.size.height * 0.5 + 4, tabBtn.frame.size.width, tabBtn.frame.size.height * 0.5 -4)];
        lable.text = self.timeAarr[i];
        lable.textColor = [UIColor whiteColor];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.font = [UIFont systemFontOfSize:12];
        [tabBtn addSubview:lable];
        ++i;
    }
}

-(void)setupInterfaceWithTitlesArr:(NSArray*)titlesArr vcArr:(NSArray*)vcArr
{
    
    MJCSegmentInterface *interFace =  [MJCSegmentInterface jc_initWithFrame:CGRectMake(0,NAVIGATION_BAR_HEIGHT,self.view.jc_width, self.view.jc_height - NAVIGATION_BAR_HEIGHT) titlesArray:titlesArr childControllerArray:vcArr interFaceStyleToolsBlock:^(MJCSegmentStylesTools *jc_tools) {
        jc_tools.jc_titleBarStyles(MJCTitlesScrollStyle).
        jc_itemSelectedSegmentIndex(0).
        jc_indicatorHidden(YES).
        jc_indicatorColor([UIColor orangeColor]).
        jc_childScollAnimalEnabled(YES).
        jc_childScollEnabled(YES).
        jc_loadAllChildViewEnabled(YES).
        jc_childsContainerBackColor([UIColor whiteColor]).
        jc_titlesViewBackColor([UIColor blackColor]).
        jc_itemTextNormalColor([UIColor whiteColor]).
        jc_itemTextSelectedColor([UIColor whiteColor]).
        jc_titlesViewFrame(CGRectMake(0, 0, self.view.jc_width, 50 * kWidthScall)).
        jc_itemTextFontSize(18).
        jc_itemTextBoldFontSizeSelected(18).
        jc_defaultItemShowCount(4);
    } hostController:self];
    interFace.delegate= self;
    [self.view addSubview:interFace];
    
}


-(NSArray *)getTitleArr{
    NSString* date;
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    date = [formatter stringFromDate:[NSDate date]];
    
    NSArray *arr = [date componentsSeparatedByString:@" "];
    NSArray *arr2 = [arr[1] componentsSeparatedByString:@":"];
    self.hour = [arr2[0] integerValue];
    
    if (self.hour % 2 != 0) {
        self.hour -= 1;
    }
    
    NSMutableArray *titleArr = [NSMutableArray new];
    NSMutableArray *timeArr = [NSMutableArray new];
    
    for (NSInteger i = self.hour; i <= 24; i += 2) {
        if (i == 24) {
            [titleArr addObject:@"00:00"];
            [timeArr addObject:@"抢购中"];
        }else{
            if (i == self.hour) {
                [timeArr addObject:@"抢购中"];
            }else{
                [timeArr addObject:@"即将开始"];
            }
            [titleArr addObject:[[NSString stringWithFormat:@"%ld",i] stringByAppendingString:@":00"]];
            
        }
        
    }
    for (int i = 0; i < self.hour; i += 2) {
        if (i != 0) {
            if (i < 10) {
                [titleArr addObject:[[@"0" stringByAppendingString:[NSString stringWithFormat:@"%d",i]] stringByAppendingString:@":00"]];
            }else{
                [titleArr addObject:[[NSString stringWithFormat:@"%d",i] stringByAppendingString:@":00"]];
            }
            [timeArr addObject:@"抢购中"];
            
        }
    }
    self.timeAarr = timeArr;
    return titleArr;
}






- (IBAction)secondSkillVCBackBtnClick:(id)sender {
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
