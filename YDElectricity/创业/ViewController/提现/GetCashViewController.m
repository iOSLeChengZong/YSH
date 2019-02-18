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

#define kNewAddGetCashAccountCell @"NewAddGetCashAccountCell"
#define kAccountCell @"AccountCell"

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
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self getCashVCRegisterCell];
}

#pragma mark -- 代理


#pragma mark -- UICollectionViewDelegate


#pragma mark -- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == self.accountArr.count) {
        return 0;
    }
    return self.accountArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == self.accountArr.count) {
        NewAddGetCashAccountCell *cell = [_getCashCollectionView dequeueReusableCellWithReuseIdentifier:kNewAddGetCashAccountCell forIndexPath:indexPath];
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
    return CGSizeZero;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsZero;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 3;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

#pragma mark -- 方法
-(void)getCashVCRegisterCell{
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
