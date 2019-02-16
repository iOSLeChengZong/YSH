//
//  CashRecordViewController.m
//  YDElectricity
//
//  Created by 元典 on 2019/2/14.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import "CashRecordViewController.h"
#import "CashRecordCell.h"
#import "CashRecordHeader.h"

#define kCashRecordCell @"CashRecordCell"
#define kCashRecordHeader @"CashRecordHeader"

@interface CashRecordViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *cashRecordCollecitonView;

@end

@implementation CashRecordViewController

#pragma mark -- 懒加载


#pragma mark -- 生命周期
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cashRecordCollecitonView.backgroundColor = kViewBGColor;
    //注册cell
    [self cashRecordRegisterCell];
    
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

    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kCashRecordHeader forIndexPath:indexPath];
    if(headerView == nil)
    {
        headerView = [[UICollectionReusableView alloc] init];
    }
    headerView.backgroundColor = [UIColor clearColor];
    
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
    return CGSizeMake(kScreenW, 15);
}

#pragma mark -- 方法
-(void)cashRecordRegisterCell{
    [self.cashRecordCollecitonView registerNib:[UINib nibWithNibName:kCashRecordCell bundle:nil] forCellWithReuseIdentifier:kCashRecordCell];
    [self.cashRecordCollecitonView registerNib:[UINib nibWithNibName:kCashRecordHeader bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kCashRecordHeader];
}

- (IBAction)cashRecordVCBackBtnClick:(id)sender {
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
