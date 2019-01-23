//
//  CommodityDetailViewController.m
//  YDElectricity
//
//  Created by 元典 on 2019/1/3.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import "CommodityDetailViewController.h"
#import "MenuHeaderView.h"

@interface CommodityDetailViewController ()<MenuHeaderViewDelegate>
@property (nonatomic,strong)UICollectionView *commodityDetailCollectionView;
@end

@implementation CommodityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MenuHeaderView *headerView = [[MenuHeaderView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, [UIScreen mainScreen].bounds.size.width, 44)];
    headerView.delegate = self;
    [self.view addSubview:headerView];
    
   
}


#pragma mark -- MenuHeaderViewDelegate
- (NSArray<MenuModel *> *)dataSourceOfView:(MenuHeaderView *)headerView
{
    NSMutableArray *list = [NSMutableArray array];
    NSArray *arr = @[@"综合",@"券后价",@"销量",@"排列"];
    for (int i=0; i<arr.count; i++) {
        MenuModel *model = [[MenuModel alloc] init];
        model.title = arr[i];
        model.index = i;
        if (i==0 ) {
            model.imageType = ImageTypeList;
            model.listData = @[@"综合排序",@"优惠券面值由高到低",@"优惠券面值由低到高",@"预估佣金由高到低"];
            model.requestWord = @"complex_order_by";
            model.requestParameters = @[@"coupon_price_desc",@"coupon_price_asc",@"commission_desc"];
        }
        if (i==1) {
            model.imageType = ImageTypeUpAndDown;
            model.requestWord = @"qhPrice_order_by";
            model.requestParameters = @[@"desc",@"asc"];
        }
        if (i==2) {
            model.imageType = ImageTypeUpAndDown;//ImageTypeNone;
            model.requestWord = @"volume_order_by";
            model.requestParameters = @[@"desc",@"asc"];
        }
        if (i==3) {
            model.imageType = ImageTypeChoose;
        }
        [list addObject:model];
    }
    
    return list;
}

- (void)didSelectedIndexPath:(GXIndexPath *)indexPath imageType:(ButtonImageType)imageType forView:(nonnull MenuHeaderView *)headerView
{
    NSArray *list = [self dataSourceOfView:headerView];
    MenuModel *model = list[indexPath.column];
    if (model.imageType == ImageTypeList) {
        NSLog(@"当前点击的是== %@ ,%@",model.title,model.listData[indexPath.row]);
    }else if (model.imageType == ImageTypeUpAndDown) {
        NSLog(@"当前点击的是== %@ ,%@",model.title,indexPath.row == 0 ? @"上" : @"下");
    }else{
        NSLog(@"当前点击的是== %@",model.title);
    }
    
}

- (void)didChooseCompletionWithData:(NSArray *)array
{
    NSLog(@"筛选条件= %@",array);
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
