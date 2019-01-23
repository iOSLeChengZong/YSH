//
//  YDIntroViewController.m
//  YDElectricity
//
//  Created by 元典 on 2018/11/28.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import "YDIntroViewController.h"


#import "ViewController.h"
#import "TestViewController.h"

#import "YDPopTopOutView.h"
#import "SDCycleScrollView.h"
#import "menuTableViewController.h"


@interface YDIntroViewController ()

@property(strong, nonatomic)NSArray<NSString *> *titles;
@property(strong, nonatomic)NSArray<UIViewController *> *childVcs;
@property (weak, nonatomic) IBOutlet SDCycleScrollView *sdScrollView;


@end

@implementation YDIntroViewController

#pragma mark -- 懒加载


#pragma mark -- 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.collectionView registerNib:[UINib nibWithNibName:@"YDIntroHeaderCell" bundle:nil] forCellWithReuseIdentifier:@"YDIntroHeaderCell"];
//    self.tm = [TestModel new];

    UIScrollView *sv = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:sv];
    
    self.title = @"效果示例";
    
    //必要的设置, 如果没有设置可能导致内容显示不正常
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    
    self.titles = @[@"精选",
                    @"母婴",
                    @"食品",
                    @"女装",
                    @"彩妆",
                    @"洗护",
                    @"内衣",
                    @"百货",
                    @"家电",
                    @"家居",
                    @"数码",
                    @"护肤"
                    ];
    // 初始化
    
    
//    self.sdScrollView.delegate = self;
//    self.sdScrollView.currentPageDotImage = [UIImage imageNamed:@""];
//    self.sdScrollView.pageDotImage = [UIImage imageNamed:@""];
//    self.sdScrollView.localizationImageNamesGroup = @[@"h1.jpg",
//                                                      @"h2.jpg",
//                                                      @"h3.jpg",
//                                                      @"h4.jpg",
//                                                      @"h7" // 本地图片请填写全名
//                                                      ];
    
    
}



#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
    
    [self.navigationController pushViewController:[NSClassFromString(@"DemoVCWithXib") new] animated:YES];
}

- (BOOL)shouldAutomaticallyForwardAppearanceMethods {
    return NO;
}


- (void)scrollPageController:(UIViewController *)scrollPageController childViewControllDidAppear:(UIViewController *)childViewController forIndex:(NSInteger)index{
    if (index == 0) {

    }
}


#pragma mark -- 方法
//collectionView 头部视图
-(void)collectionViewForHeaderView
{
    
}

- (IBAction)sortBtnClick:(id)sender {
    menuTableViewController *menuVC = [[menuTableViewController alloc] init];
    
    [self showViewController:menuVC sender:nil];
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
