//
//  GetCashViewController.m
//  YDElectricity
//
//  Created by 元典 on 2019/2/18.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import "GetCashViewController.h"
#import "NewAddGetCashAccountCell.h"
#import "AccountCell.h"
#import "NewAddGetCashViewController.h"

#define kNewAddGetCashAccountCell @"NewAddGetCashAccountCell"
#define kAccountCell @"AccountCell"
#define kNewAddGetCashViewController @"NewAddGetCashViewController"

@interface GetCashViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *getCashCollectionView;
@property (nonatomic,strong) NSMutableArray *accountArr;

@end

@implementation GetCashViewController


#pragma mark -- 生命周期
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self getCashVCRegisterCell];
}

#pragma mark -- 代理


#pragma mark -- UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        //跳转新增提现账户
        UIStoryboard *board = [UIStoryboard storyboardWithName:kYDBusiness bundle:nil];
        NewAddGetCashViewController *nVC = [board instantiateViewControllerWithIdentifier:kNewAddGetCashViewController];
        [self.navigationController pushViewController:nVC animated:YES];
        
    }
}

#pragma mark -- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;//self.accountArr.count;
    }
    return  1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        NewAddGetCashAccountCell *cell = [_getCashCollectionView dequeueReusableCellWithReuseIdentifier:kNewAddGetCashAccountCell forIndexPath:indexPath];
        [cell viewcornerRadius:cell.bounds.size.height * 0.5 borderWith:0.01 clearColor:YES];
        return cell;
    }
    AccountCell *cell = [_getCashCollectionView dequeueReusableCellWithReuseIdentifier:kAccountCell forIndexPath:indexPath];
    return cell;
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

#pragma mark -- UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return CGSizeMake(357*kWidthScall, 137 * kWidthScall);
    }
    return CGSizeMake(209*kWidthScall, 42 * kWidthScall);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (section == 0) {
        return UIEdgeInsetsMake(18, (kScreenW - 357 * kWidthScall) * 0.5, 25, (kScreenW - 357 * kWidthScall) * 0.5);
    }
    
    if (!self.accountArr.count) {
        return UIEdgeInsetsMake(-30, (kScreenW - 209 * kWidthScall) * 0.5, 7, (kScreenW - 209 * kWidthScall) * 0.5);
    }else{
        return UIEdgeInsetsMake(3, (kScreenW - 209 * kWidthScall) * 0.5, 7, (kScreenW - 209 * kWidthScall) * 0.5);
    }
    
    
    
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 7;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

#pragma mark -- 方法
-(void)getCashVCRegisterCell{
    self.getCashCollectionView.backgroundColor = kViewBGColor;
    [_getCashCollectionView registerNib:[UINib nibWithNibName:kNewAddGetCashAccountCell bundle:nil] forCellWithReuseIdentifier:kNewAddGetCashAccountCell];
    [_getCashCollectionView registerNib:[UINib nibWithNibName:kAccountCell bundle:nil] forCellWithReuseIdentifier:kAccountCell];
}

#pragma mark -- 连线

- (IBAction)getCashVCBackBtnClick:(id)sender {
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
