//
//  GrowthRecordViewController.m
//  YDElectricity
//
//  Created by 元典 on 2019/2/16.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import "GrowthRecordViewController.h"
#import "GoldTaskCollectionViewCell.h"
#import "CashRecordHeader.h"

#define kGoldTaskCollectionViewCell @"GoldTaskCollectionViewCell"
#define kCashRecordHeader @"CashRecordHeader"

@interface GrowthRecordViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *growthRecordCollectionView;

@end

@implementation GrowthRecordViewController

#pragma mark -- 懒加载


#pragma mark -- 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    //注册cell
    [self growthRecordVCRegisterCell];
}

#pragma mark -- 代理
#pragma mark -- UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@,---%ld",[self class],indexPath.row);
}


#pragma mark -- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 20;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GoldTaskCollectionViewCell *cell = [self.growthRecordCollectionView dequeueReusableCellWithReuseIdentifier:kGoldTaskCollectionViewCell forIndexPath:indexPath];
    //    cell.nameImage.image = [UIImage imageNamed:self.cellImageNames[indexPath.row]];
    return cell;
}



- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

// The view that is returned must be retrieved from a call to -dequeueReusableSupplementaryViewOfKind:withReuseIdentifier:forIndexPath:
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    CashRecordHeader *header = [self.growthRecordCollectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kCashRecordHeader forIndexPath:indexPath];
    return header;
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

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(kScreenW, 15);
}
#pragma mark -- 方法
-(void)growthRecordVCRegisterCell{
    [_growthRecordCollectionView registerNib:[UINib nibWithNibName:kGoldTaskCollectionViewCell bundle:nil] forCellWithReuseIdentifier:kGoldTaskCollectionViewCell];
    [_growthRecordCollectionView registerNib:[UINib nibWithNibName:kCashRecordHeader bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kCashRecordHeader];
}

- (IBAction)growthRecordVCBackBtncClick:(id)sender {
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
