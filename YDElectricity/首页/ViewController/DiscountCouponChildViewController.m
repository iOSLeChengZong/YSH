//
//  DiscountCouponChildViewController.m
//  YDElectricity
//
//  Created by 元典 on 2019/2/19.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import "DiscountCouponChildViewController.h"
#import "DiscountCouponCell.h"

#define kDiscountCouponCell @"DiscountCouponCell"

@interface DiscountCouponChildViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView *couponCollectionView;
@end

@implementation DiscountCouponChildViewController
#pragma mark -- 懒加载
-(UICollectionView *)couponCollectionView{
    if (!_couponCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _couponCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH - NAVIGATION_BAR_HEIGHT - 50) collectionViewLayout:layout];
        _couponCollectionView.backgroundColor = kViewBGColor;
        _couponCollectionView.delegate = self;
        _couponCollectionView.dataSource = self;
        
        //itemSize
        layout.itemSize = CGSizeMake(357 * kWidthScall, 93 * kWidthScall);
        //间距
        layout.sectionInset = UIEdgeInsetsMake(10 * kWidthScall, (kScreenW - 357 * kWidthScall) * 0.5, 7 * kWidthScall, (kScreenW - 357 * kWidthScall) * 0.5);//UIEdgeInsetsMake(10 , 9 , 7, 9);
        //最小行间距
        layout.minimumLineSpacing = 3;
        //最大行间距
        layout.minimumInteritemSpacing = 0;
        
        //注册cell
        [_couponCollectionView registerNib:[UINib nibWithNibName:kDiscountCouponCell bundle:nil] forCellWithReuseIdentifier:kDiscountCouponCell];
        
        [self.view addSubview:_couponCollectionView];
        
    }
    return _couponCollectionView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark -- collectionViewDataSource
//item数量
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 20;
}

//item的外观
// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DiscountCouponCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kDiscountCouponCell forIndexPath:indexPath];
    
    
    return cell;
    
    
}

//分区数量
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


#pragma mark -- collectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"indexPath:%lu",indexPath.row);
    if (indexPath.section != 0) {
        //跳转淘宝客
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"YDHome" bundle:nil];
//        TaoBaoCustomerDetailViewController *taoBaoVc = [storyboard instantiateViewControllerWithIdentifier:@"TaoBaoCustomerDetailViewController"];
//
//        [self.navigationController pushViewController:taoBaoVc animated:YES];
    }
    
}

#pragma mark -- collectionViewDelegateFlowLayout
//item尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(357 * kWidthScall, 93*kWidthScall);
}

//分区之间间隙
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10 * kWidthScall, (kScreenW - 357 * kWidthScall) * 0.5, 7 * kWidthScall, (kScreenW - 357 * kWidthScall) * 0.5);
}
//最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 7 * kWidthScall;
}

//最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

#pragma mark -- 方法
-(void)request{
    [self.couponCollectionView addHeaderRefreshingBlock:^{
        
    }];
    [self.couponCollectionView addFooterBackRefresh:^{
        
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
