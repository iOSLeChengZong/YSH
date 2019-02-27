//
//  CategoryViewController.m
//  jdmobile
//
//  Created by SYETC02 on 15/6/12.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import "CategoryViewController.h"
#import "SearchBarView.h"
#import "CategoryMeunModel.h"
#import "MultilevelMenu.h"
#import "AppDelegate.h"
#import "CategoryViewModel.h"
#import "Factory.h"
#import "CommodityListlViewController.h"

@interface CategoryViewController ()<SearchBarViewDelegate>
{
    NSMutableArray * _list;
}
@property(nonatomic,copy)CategoryViewModel *categoryVM;
@end

@implementation CategoryViewController
#pragma mark -- 懒加载
-(CategoryViewModel *)categoryVM{
    if (!_categoryVM) {
        _categoryVM = [CategoryViewModel new];
    }
    return _categoryVM;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //获取数据
    [self.view showBusyHUD];
    [self.categoryVM getCategoryLeftData:^(NSError * _Nonnull error) {
        [self.view hideBusyHUD];
        [self initCategoryMenu];
        
    }];
    
    //设置背景颜色
    self.view.backgroundColor = kViewBGColor;
    //设置导航栏
    [self setupNavigationItem];
    
}

- (void)viewWillAppear:(BOOL)animated;
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)setupNavigationItem {
    
//    self.navigationItem.rightBarButtonItem = [UIBarButtonItem BarButtonItemWithBackgrounImageName:@"" highBackgroundImageName:nil target:self aciton:nil];
    //将搜索条放在一个UIView上
//    SearchBarView *searchView = [[SearchBarView alloc]initWithFrame:CGRectMake(0, 7, self.view.frame.size.width-60 , 30)];
//    searchView.delegate=self;
    //     self.navigationItem.titleView = searchView;
    
    [Factory addSearchItemToVC:self clickHandler:^{
        NSLog(@"搜索被点击了");
        [Factory showWaittingForOpened];
    }];
    

}

- (void)cameraClick{
    
}

#pragma mark - 🔌 SearchBarViewDelegate Method
- (void)searchBarSearchButtonClicked:(SearchBarView *)searchBarView {
    NSLog(@"11111");
}

- (void)searchBarAudioButtonClicked:(SearchBarView *)searchBarView {
    NSLog(@"11111");
}


- (void)initData{
    

    _list=[NSMutableArray arrayWithCapacity:0];
    
    NSString *path=[[NSBundle mainBundle] pathForResource:@"Category" ofType:@"plist"];
    NSArray *array=[NSArray arrayWithContentsOfFile:path];
    /**
     *  构建需要数据 2层或者3层数据 (ps 2层也当作3层来处理)
     */
    
    for (int i=0; i<[array count]; i++) {//遍历plist所有item
        
        CategoryMeunModel * meun=[[CategoryMeunModel alloc] init];
        meun.menuName=[array objectAtIndex:i][@"menuName"];
        meun.nextArray=[array objectAtIndex:i][@"topMenu"];
        NSMutableArray * sub=[NSMutableArray arrayWithCapacity:0];
        
        for ( int j=0; j <[meun.nextArray count]; j++) {//遍历item内部topmenu
            
            CategoryMeunModel * meun1=[[CategoryMeunModel alloc] init];
            meun1.menuName=[meun.nextArray objectAtIndex:j][@"topName"];
            meun1.nextArray=[meun.nextArray objectAtIndex:j][@"typeMenu"];
            
            
            
            NSMutableArray *zList=[NSMutableArray arrayWithCapacity:0];
            for ( int k=0; k <[meun1.nextArray count]; k++) {//遍历topmenu内部
                CategoryMeunModel * meun2=[[CategoryMeunModel alloc] init];
                meun2.menuName=[meun1.nextArray objectAtIndex:k][@"typeName"];
                meun2.urlName=[meun1.nextArray objectAtIndex:k][@"typeImg"];
                [zList addObject:meun2];
            }
            
            
            meun1.nextArray=zList;
            [sub addObject:meun1];
        }
        
        
        meun.nextArray=sub;
        [_list addObject:meun];
    }
    
}


- (void)initCategoryMenu{
   
    WK(weakSelf)
    MultilevelMenu * view=[[MultilevelMenu alloc] initWithFrame:CGRectMake(0, 2, self.view.width, self.view.height - 2) WithModel:self.categoryVM withSelectIndex:^(NSString *right,NSString *vcTitle/*, NSInteger right,CategoryMeunModel * info*/) {
        
//        NSLog(@"点击的 菜单%@",info.menuName);
//         JDNavigationController *navigationController = [[JDNavigationController alloc] initWithRootViewController:[[CommodityTableViewController alloc] init]];
//        
//        JDNavigationController *menuController = [[JDNavigationController alloc]  initWithRootViewController:[[RightMenuTableViewController alloc] init]];
//        REFrostedViewController *frostedViewController = [[REFrostedViewController alloc] initWithContentViewController:navigationController menuViewController:menuController];
//        frostedViewController.direction = REFrostedViewControllerDirectionRight;
//        frostedViewController.liveBlurBackgroundStyle = REFrostedViewControllerLiveBackgroundStyleLight;
//           [frostedViewController setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
//        [self presentViewController:frostedViewController animated:YES completion:nil];
        
         //[self.navigationController pushViewController:frostedViewController animated:YES];
        
        UIStoryboard *storybord = [UIStoryboard storyboardWithName:@"YDHome" bundle:nil];
        CommodityListlViewController *CLVC = [storybord instantiateViewControllerWithIdentifier:@"CommodityListlViewController"];
        CLVC.title = vcTitle;
        CLVC.goodID = right;
        CLVC.listState = GoodListStateCategory;
        [weakSelf.navigationController pushViewController:CLVC animated:YES];
        
    }];
    
//   view.needToScorllerIndex=0; //默认是 选中第一行
//    view.oldCellIndex = 0;//上一个被点击的cell默认为0;
//    view.leftSelectColor=kRGBA(45, 188, 157, 1.0); //选中字体的颜色为原型图颜色
//    view.leftSelectBgColor=[UIColor whiteColor];//选中背景颜色
//    view.leftUnSelectColor = kRGBA(45, 188, 157, 1.0);
//    view.isRecordLastScroll=NO;//是否记住当前位置
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)categoryVCBackBtnClick:(id)sender {
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
