//
//  CashDetailViewController.m
//  YDElectricity
//
//  Created by 元典 on 2019/2/15.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import "CashDetailViewController.h"
#import "CashRecordCell.h"
#import "CashDetailHeader.h"


#define kCashRecordCell @"CashRecordCell"
#define kCashDetailHeader @"CashDetailHeader"

@interface CashDetailViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *cashDetailCollectionView;

@end

@implementation CashDetailViewController


#pragma mark -- 生命周期
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [Factory findHairlineImageViewUnder:self.navigationController.navigationBar].hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [Factory findHairlineImageViewUnder:self.navigationController.navigationBar].hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self cashDetailVCRegisterCell];
    
}


#pragma mark -- 代理
#pragma mark -- UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@,%ld",[self class],indexPath.row);
}
#pragma mark -- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 30;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CashRecordCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCashRecordCell forIndexPath:indexPath];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    CashDetailHeader *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kCashDetailHeader forIndexPath:indexPath];
    
    return headerView;
}

#pragma mark -- UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return kItemSize;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return kUIEdgeInsets;
    
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 3;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)collectionViewLayout;
    layout.sectionHeadersPinToVisibleBounds = YES;
    return CGSizeMake(kScreenW, 34 * kWidthScall);
}


#pragma mark -- 方法
-(void)cashDetailVCRegisterCell{
    [_cashDetailCollectionView registerNib:[UINib nibWithNibName:kCashRecordCell bundle:nil] forCellWithReuseIdentifier:kCashRecordCell];
    [_cashDetailCollectionView registerNib:[UINib nibWithNibName:kCashDetailHeader bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kCashDetailHeader];
}

- (IBAction)cassDetailVCBackBtnClick:(id)sender {
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
